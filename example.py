tb_digital_name = f"{tb_spec['blocks']['digital']['name']}.sv"
tb_digital_templ = AV_bench_env.get_template('tb_digital.sv')
tb_digital = tb_digital_templ.render(tb_spec["blocks"]["digital"])
with open(f"{tb_path}/{tb_digital_name}","w") as f:
    f.write(tb_digital)


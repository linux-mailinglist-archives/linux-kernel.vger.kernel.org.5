Return-Path: <linux-kernel+bounces-3933-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3355B817540
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 16:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B8761C2392D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 15:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A986C4988E;
	Mon, 18 Dec 2023 15:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qwQYUoyB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215C44988F
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 15:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BIFVGR1094991;
	Mon, 18 Dec 2023 09:31:16 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1702913476;
	bh=JgROoeiy1Q7XFUjCXi0eGpUzXaxOpBhg7xGq2bl+6WA=;
	h=Date:From:To:CC:Subject;
	b=qwQYUoyBjJohKAiKKvHrrck+DhxdtiRQUmAO9VVJzzGjLLYAtiKZ9yi5IAT9UTIzY
	 JArrkRtRLZaOkpWCq2UiIggsens/aNGvbWJBqMWLfNpyN0e8tW1lmW0XDvyEiS335D
	 +3Ao3wfTBUhDPnr+nJ5ggFRXEzVx8+/e+JMj/usw=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BIFVGWv001638
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 18 Dec 2023 09:31:16 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 18
 Dec 2023 09:31:16 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 18 Dec 2023 09:31:16 -0600
Received: from localhost (uda0133052.dhcp.ti.com [128.247.81.232])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BIFVFiV102341;
	Mon, 18 Dec 2023 09:31:16 -0600
Date: Mon, 18 Dec 2023 09:31:15 -0600
From: Nishanth Menon <nm@ti.com>
To: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC: Tero Kristo <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 3/3] arm64: dts: ti: Updates for v6.8 for TI K3 platforms
Message-ID: <20231218153115.szyd22tmoumqkn6g@occupier>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="shzh2zxf3dag5cku"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

--shzh2zxf3dag5cku
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-d=
t-for-v6.8

for you to fetch changes up to 8bbe8a7dbaabb84d93321f116966af73ba6a7233:

  arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed mode=
 (2023-12-15 10:05:58 -0600)

----------------------------------------------------------------
TI K3 device tree updates for v6.8

New features across K3 SoCs:
- ov5640 and imx219 sensor overlays added to various am62x/am62a boards.
- TP6594 and family support for J7200, j721s2,j721e, am69/j784s4 boards

Generic Fixes:
- minor white space cleanups
- Addition of optional regs for more complete DMA description across all K3
  SoCs.

Misc:
- chip_id node moves under wkup_conf bus.
- COMPILE_TEST+OF_ALL_DTBS is now standard usage for testing overlays.

SoC specific Fixes/Features:
AM62A
 - gpio pin count fixups.
AM625
 - Adds verdin am62x-mallow board
 - Adds IMG's AXE-RGX GPU support
 - Adds gpio-ranges support for main domain GPIOs.
 - SK now defaults to mcu gpio marked as reserved to cater to MCU use cases
AM64
 - EVM/SK now defaults to mcu gpio marked as reserved to cater to MCU use c=
ases
AM65
 - Fix for DSS Irq trigger type, proper fixup for dss-oldi-io-ctrl node
 - misc splitup to make AM652 device variant reusable
J7200
 - mmc: itap delay fixups for DDR52
J721S2/AM68
 - mmc: itap delay fixups for DDR50
J784S4/AM69
 - mmc: itap delay fixups for DDR50

Board specific fixes/Features:
- iot2050 cleanups for enabling icssg-prueth nodes, runtime pinmuxing,
  dropping ecap0pwm nodes, misc cleanups.
- am62x-verdin adds uart2, minor fixups for spi1 chip-select pinctrl
- am62-phycore adds hdmi support
- am64-phycore adds R5F support.
- am62x-beagleplay renames console uart pinmuxes.

----------------------------------------------------------------
Andrew Davis (11):
      arm64: dts: ti: k3-am64-main: Fix typo in epwm_tbclk node name
      arm64: dts: ti: k3-am65: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j7200: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j721e: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j721s2: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-j784s4: Add chipid node to wkup_conf bus
      arm64: dts: ti: k3-am65: Add full compatible to dss-oldi-io-ctrl node
      arm64: dts: ti: k3-am65: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-am64: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-am625-beagleplay: Use UART name in pinmux name
      arm64: dts: ti: k3-am65: Add AM652 dtsi file

Aradhya Bhatia (1):
      arm64: dts: ti: k3-am62a7-sk: Add interrupt support for IO Expander

Benedikt Niedermayr (1):
      arm64: dts: ti: iot2050: Definitions for runtime pinmuxing

Bhavya Kapoor (3):
      arm64: dts: ti: k3-j7200-main: Add Itap Delay Value For DDR52 speed m=
ode
      arm64: dts: ti: k3-j721s2-main: Add Itap Delay Value For DDR50 speed =
mode
      arm64: dts: ti: k3-j784s4-main: Add Itap Delay Value For DDR50 speed =
mode

Esteban Blanc (2):
      arm64: dts: ti: k3-j7200-som-p0: Add TP6594 family PMICs
      arm64: dts: ti: k3-j721s2-som-p0: Add TP6594 family PMICs

Garrett Giordano (4):
      arm64: dts: ti: phycore-am64: Add R5F DMA Region and Mailboxes
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Lower I2C1 frequency
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Add HDMI support
      arm64: dts: ti: k3-am625-phyboard-lyra-rdk: Remove HDMI Reset Line Na=
me

Jai Luthra (8):
      arm64: dts: ti: k3-am62-main: Enable CSI2-RX
      arm64: dts: ti: k3-am62a-main: Enable CSI2-RX
      arm64: dts: ti: k3-am625-beagleplay: Add overlays for OV5640
      arm64: dts: ti: k3-am62x-sk: Enable camera peripherals
      arm64: dts: ti: k3-am62x: Add overlays for OV5640
      arm64: dts: ti: k3-am62a7-sk: Enable camera peripherals
      arm64: dts: ti: k3-am62x: Add overlay for IMX219
      arm64: dts: ti: Use OF_ALL_DTBS for combined blobs

Jan Kiszka (3):
      arm64: dts: ti: iot2050: Re-add aliases
      arm64: dts: ti: iot2050: Drop unused ecap0 PWM
      arm64: dts: ti: iot2050: Add icssg-prueth nodes for PG2 devices

Jerome Neanne (2):
      arm64: dts: ti: k3-j721e-som-p0: Add TP6594 family PMICs
      arm64: dts: ti: k3-j784s4-evm: Add support for TPS6594 PMIC

Joao Paulo Goncalves (3):
      arm64: dts: ti: verdin-am62: Improve spi1 chip-select pinctrl
      dt-bindings: arm: ti: Add verdin am62 mallow board
      arm64: dts: ti: Add verdin am62 mallow board

Krzysztof Kozlowski (1):
      arm64: dts: ti: minor whitespace cleanup around '=3D'

Manorit Chawdhry (2):
      arm64: dts: ti: k3-am65: Add additional regs for DMA components
      arm64: dts: ti: k3-j7*: Add additional regs for DMA components

Neha Malcom Francis (2):
      arm64: dts: ti: k3-am69-sk: Add support for TPS6594 PMIC
      arm64: dts: ti: k3-j721e-sk: Add TPS6594 family PMICs

Nitin Yadav (1):
      arm64: dts: ti: k3-am62a-main: Fix GPIO pin count in DT nodes

Parth Pancholi (1):
      arm64: dts: ti: k3-am625-verdin: Enable Verdin UART2

Ronald Wahl (1):
      arm64: dts: ti: k3-am62-main: Add gpio-ranges properties

Sarah Walker (1):
      arm64: dts: ti: k3-am62-main: Add GPU device node

Siddharth Vadapalli (3):
      arm64: dts: ti: k3-am68-sk-base-board: Add alias for MCU CPSW2G
      arm64: dts: ti: k3-j721e-evm: Add overlay for PCIE0 Endpoint Mode
      arm64: dts: ti: k3-j721s2-evm: Add overlay for PCIE1 Endpoint Mode

Su Bao Cheng (1):
      arm64: dts: ti: iot2050: Refactor the m.2 and minipcie power pin

Tomi Valkeinen (1):
      arm64: dts: ti: k3-am65-main: Fix DSS irq trigger type

Vignesh Raghavendra (4):
      arm64: dts: ti: k3-am642-evm/sk: Mark mcu_gpio_intr as reserved
      arm64: dts: ti: k3-am62p5-sk: Mark mcu gpio and mcu_gpio_intr as rese=
rved
      arm64: dts: ti: k3-am62x-sk-common: Mark mcu gpio and mcu_gpio_intr a=
s reserved
      arm64: dts: ti: k3-am6*: Add additional regs for DMA components

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |   2 +
 arch/arm64/boot/dts/ti/Makefile                    |  70 +-
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |  96 ++-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi  |   3 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi     |   3 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi  | 188 +++++
 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi   |   3 +-
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi         |  17 +-
 .../dts/ti/k3-am625-beagleplay-csi2-ov5640.dtso    |  77 ++
 .../ti/k3-am625-beagleplay-csi2-tevi-ov5640.dtso   |  77 ++
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     |   4 +-
 .../boot/dts/ti/k3-am625-phyboard-lyra-rdk.dts     |  98 ++-
 .../boot/dts/ti/k3-am625-verdin-nonwifi-mallow.dts |  22 +
 .../boot/dts/ti/k3-am625-verdin-wifi-mallow.dts    |  22 +
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          | 121 ++-
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  39 +
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi          |  18 +-
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            |   9 +
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |  16 +
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso |  84 +++
 .../arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso |  82 ++
 .../boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso  |  82 ++
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  22 +-
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    | 103 ++-
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |  12 +-
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  |   1 +
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |  10 +-
 .../boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    |   1 -
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi     |   1 +
 .../boot/dts/ti/k3-am65-iot2050-common-pg1.dtsi    |  10 +-
 .../boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   4 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi | 826 +++++++++++++++++=
++--
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  16 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |   8 +-
 arch/arm64/boot/dts/ti/k3-am65-wakeup.dtsi         |  13 +-
 arch/arm64/boot/dts/ti/k3-am652.dtsi               |  74 ++
 .../dts/ti/k3-am6528-iot2050-basic-common.dtsi     |  16 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   2 +
 .../dts/ti/k3-am6548-iot2050-advanced-common.dtsi  |   2 +
 .../boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts  |  12 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   |   1 +
 arch/arm64/boot/dts/ti/k3-am69-sk.dts              |  96 ++-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |   9 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |  21 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        | 153 ++++
 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso  |  53 ++
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |   8 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  21 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             | 151 ++++
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        | 160 ++++
 arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso |  53 ++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         |   9 +-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |  21 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       | 193 +++++
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           | 102 +++
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         |   9 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  22 +-
 57 files changed, 3183 insertions(+), 165 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62-verdin-mallow.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-ov5640.=
dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-beagleplay-csi2-tevi-ov=
5640.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-nonwifi-mallow.d=
ts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am625-verdin-wifi-mallow.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-imx219.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-ov5640.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-csi2-tevi-ov5640.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am652.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-pcie0-ep.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-pcie1-ep.dtso

--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--shzh2zxf3dag5cku
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmWAZb0ACgkQ3bWEnRc2
JJ3acA/+MRHfupjgNxWoj4X/4SB07UkhWHa9niVEx0MzJN1W16Uu27GTx/0WJzvV
g6tyPdZFXpAwECC3/sIns9fZZyMGcih4Ai05lnp/+SA3doeVGvZA7V/Kjbm+5F63
IH4oXPOElpHc//W67sqDPB4ulCwa5V3pwEMZJi5qc4uxFWnf2A8t5ROSwXyoAd4c
LfU2lZOnrPw7V3gd6iGr/OxbvqS+vw3pMv5zOeEXdgdOHuqIQgJyiokah1O/Ghne
QN1HWEF/+bi0oxg5gz8N1MXiRTW7I5/cLeMIxN1Zei/VjwvDv3pDBEqvLsUKeTqY
L36eZw22M5OyXSQj4OVVZw4IWUuJmelcLgF9M27hb5tLA/J0VcJIYvrhMrjJDE0q
/oQXVV7lzfvBn+i+5lU2fCE97eXRht6YEX60yAxmwZl1PBAHInm1ElkU08BYa+Kk
GauhjX87O1Qry2Brh5g3Y/CGknXy8fQlwiFM7dHfncKwBhmj5fZQqlROQjtSG+eQ
DRn48zaMJ8Plr5a8mngwmrfP8qXg8Nq5l/iY4rjKL1NCnYunzgWTUSeX2Ydu7GZO
x4/PobaQZSP/BM6Z0UE4Aikz2rnpeI8sNuMpZBiqhC1jzUPDwGLEbW2wrLry8qbi
kXqLVwrAoPoCfqkr17ZPvqvx4Q6xPxlp+S9a+VjHPVhpHOibrdA=
=567d
-----END PGP SIGNATURE-----

--shzh2zxf3dag5cku--


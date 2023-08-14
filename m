Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88C8577BDA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 18:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjHNQHN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 12:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231446AbjHNQHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 12:07:01 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F98E115
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 09:07:00 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37EG6qR6100357;
        Mon, 14 Aug 2023 11:06:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692029212;
        bh=aQGUe+efl7KtjGZRJpZUB7p1aALvrKDgZfW82fI9+n8=;
        h=Date:From:To:CC:Subject;
        b=W5LN5M+Z7ow+Vppww3ZWNMDlgNkQ5+tM2k2e6eoD63f350CiS8ALpj+cjOqJclJAO
         pHA/v5r7wVZY2fKP3pzvwde0NG3DtSBJRfm1LOqC81ZpUQeFFh79pcEOTKXKU41px/
         rsiPaliqhzGtQoQ8Jd1eONmuX8nPTGCDiGI3WlLw=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37EG6qPK016729
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 14 Aug 2023 11:06:52 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 14
 Aug 2023 11:06:51 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 14 Aug 2023 11:06:51 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37EG6pcX087277;
        Mon, 14 Aug 2023 11:06:51 -0500
Date:   Mon, 14 Aug 2023 11:06:51 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Tero Kristo <kristo@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nishanth Menon <nm@ti.com>
Subject: [GIT PULL 3/4] arm64: dts: ti: Updates for v6.6
Message-ID: <20230814160651.frxohyshd2evp2k4@expenses>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lqjytuxbkvkshjzk"
Content-Disposition: inline
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--lqjytuxbkvkshjzk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Please pull:

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git tags/ti-k3-d=
t-for-v6.6

for you to fetch changes up to 9e77200356badfda6cec99e37be55fa940f83c7d:

  arm64: dts: ti: verdin-am62: Add DSI display support (2023-08-13 07:58:55=
 -0500)

----------------------------------------------------------------
TI K3 device tree updates for v6.6

New Boards:
 - TQ group's TQMaX4XxL AM64 SOM and MBaX4XxL carrier board
 - TI's AM62P5 Starter Kit (SK)

New features:
AM625:
 - Support for Display (parallel only) - hdmi+audio support for
   AM625-SK/BeaglePlay, TC358778 DPI to MIPI-DSI bridge support
   for verdin.
 - MCU MCAN support and enable of Toradex Verdin
 - Toradex Verdin Dahlia audio support
AM62A7:
 - MCU MCAN support
 - Enable USB Dual Role Device(DRD) support for AM62A7
   Starter Kit(SK).
AM64:
 - TQ group's tqma64xxl: Overlays for SD-card and wlan.
J721E:
 - Main domain CPSW9G and correponding gateway/ethernet
   switch expansion - GESI board.
J721S2/AM68:
 - New CAN instances, ehrpwm, Display (DSS) and am68-sk HDMI support
 - Main domain CPSW2G and correponding gateway/ethernet
   switch expansion - GESI board.
J784S4/AM69:
 - Boot phase tag marking in device tree
 - UFS support

Cleanups and non-urgent fixes:
 - Cosmetic style fixups around "=3D" and "{" whitespace usage.
 - Fixups across multiple SoCs/boards for pwm-tbclk to matchup with
   bindings
 - Serdes header file include/dt-bindings/mux/ti-serdes.h is now
   deprecated, use k3-serdes.h in soc dtsi folder.
 - All SoCs: Enable GPIO/SDHCI/OSPI/TSADC/C6/C7 DSP nodes at the
   board level.
 - Fixups for AM62: Crypto powerdomains are conditional to better
   represent control of the crypto engines by security controller.
 - Fixups for j721e: Duplicate wakeup_i2c node dropped for SoM board.
 - Fixups for j721s2/am68: pimux offsets for OSPI.
 - Fixups for j784s4/am69: Fixups for pinmux for ospi/adc interrupt
   ranges for wkup/main gpios

----------------------------------------------------------------
Andrew Davis (19):
      arm64: dts: ti: k3-am62a: Remove syscon compatible from epwm_tbclk
      arm64: dts: ti: k3-am64: Merge the two main_conf nodes
      arm64: dts: ti: k3: Fix epwm_tbclk node name to generic name
      arm64: dts: ti: k3-j721e: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-j7200: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable SDHCI nodes at the board level
      arm64: dts: ti: k3-am65: Enable OSPI nodes at the board level
      arm64: dts: ti: k3-j721e: Enable OSPI nodes at the board level
      arm64: dts: ti: k3-j7200: Enable OSPI nodes at the board level
      arm64: dts: ti: k3-am64: Enable OSPI nodes at the board level
      arm64: dts: ti: k3-j721e: Enable GPIO nodes at the board level
      arm64: dts: ti: k3-j721s2: Enable GPIO nodes at the board level
      arm64: dts: ti: k3-j7200: Enable GPIO nodes at the board level
      arm64: dts: ti: k3-j721e: Enable TSCADC nodes at the board level
      arm64: dts: ti: k3-am65: Enable TSCADC nodes at the board level
      arm64: dts: ti: k3-am64: Enable TSCADC nodes at the board level
      arm64: dts: ti: k3-j721e: Enable C7x DSP nodes at the board level
      arm64: dts: ti: k3-j784s4: Enable C7x DSP nodes at the board level
      arm64: dts: ti: k3-j721e: Enable C6x DSP nodes at the board level

Apelete Seketeli (1):
      arm64: dts: ti: k3-j784s4: Fix interrupt ranges for wkup & main gpio

Apurva Nandan (3):
      arm64: dts: ti: k3-j784s4: Add phase tags marking
      arm64: dts: ti: k3-j784s4-evm: Add phase tags marking
      arm64: dts: ti: k3-am69-sk: Add phase tags marking

Aradhya Bhatia (3):
      arm64: dts: ti: k3-am62x-sk-common: Update main-i2c1 frequency
      arm64: dts: ti: k3-am62-main: Add node for DSS
      arm64: dts: ti: k3-am62x-sk-common: Add HDMI support

Bhavya Kapoor (1):
      arm64: dts: ti: k3-j721s2: Add support for CAN instances 3 and 5 in m=
ain domain

Bryan Brattlof (3):
      dt-bindings: arm: ti: Add bindings for AM62P5 SoCs
      arm64: dts: ti: Introduce AM62P5 family of SoCs
      arm64: dts: ti: Add support for the AM62P5 Starter Kit

Dhruva Gole (1):
      arm64: dts: ti: k3-*: fix fss node dtbs check warnings

Francesco Dolcini (4):
      arm64: dts: ti: verdin-am62: Set I2S_1 MCLK rate
      arm64: dts: ti: verdin-am62: dev: add sound card
      arm64: dts: ti: verdin-am62: dahlia: add sound card
      arm64: dts: ti: verdin-am62: Add DSI display support

Hiago De Franco (1):
      arm64: dts: ti: k3-am625-verdin: enable CAN_2

Jai Luthra (2):
      arm64: dts: ti: k3-am62: Enable AUDIO_REFCLKx
      arm64: dts: ti: am62x-sk: Add overlay for HDMI audio

Jayesh Choudhary (4):
      arm64: dts: ti: Use local header for SERDES MUX idle-state values
      dt-bindings: ti-serdes-mux: Deprecate header with constants
      arm64: dts: ti: k3-j721s2-main: Add DSS node
      arm64: dts: ti: k3-am68-sk-base-board: Add HDMI support

Judith Mendez (2):
      arm64: dts: ti: k3-am62: Add MCU MCAN nodes
      arm64: dts: ti: k3-am62a7: Add MCU MCAN nodes

Kamlesh Gurudasani (2):
      dt-bindings: crypto: ti,sa2ul: make power-domains conditional
      arm64: dts: ti: k3-am62-main: Remove power-domains from crypto node

Kishon Vijay Abraham I (2):
      arm64: dts: ti: k3-j721s2-main: Add main CPSW2G devicetree node
      arm64: dts: ti: k3-j721s2: Add overlay to enable main CPSW2G with GESI

Krzysztof Kozlowski (2):
      arm64: dts: ti: minor whitespace cleanup around '=3D'
      arm64: dts: ti: add missing space before {

Matthias Schiffer (3):
      dt-bindings: arm: ti: Add compatible for AM642-based TQMaX4XxL SOM fa=
mily and carrier board
      arm64: dts: ti: Add TQ-Systems TQMa64XxL SoM and MBaX4XxL carrier boa=
rd Device Trees
      arm64: dts: ti: k3-am64-tqma64xxl-mbax4xxl: add SD-card and WLAN over=
lays

Nishanth Menon (4):
      arm64: dts: ti: Fix compatible of ti,*-ehrpwm-tbclk
      arm64: dts: ti: k3-pinctrl: Introduce debounce select mux macros
      arm64: dts: ti: k3: Fixup remaining pin group node names for make dtb=
s checks
      arm64: dts: ti: k3-am625-beagleplay: Add HDMI support

Ravi Gunasekaran (1):
      arm64: dts: ti: k3-am62a7-sk: Enable dual role support for Type-C port

Siddharth Vadapalli (1):
      arm64: dts: ti: k3-j721e: Add overlay to enable CPSW9G ports with GESI

Sinthu Raja (1):
      arm64: dts: ti: k3-j721s2-main: Add dts nodes for EHRPWMs

Udit Kumar (6):
      arm64: dts: ti: k3-j721e-som-p0: Remove Duplicated wkup_i2c0 node
      arm64: dts: ti: k3-j784s4-main: Add DT node for UFS
      arm64: dts: ti: k3-j784s4-evm: Add Support for UFS peripheral
      arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ospi
      arm64: dts: ti: k3-j721s2: correct pinmux offset for ospi
      arm64: dts: ti: k3-j784s4-evm: Correct Pin mux offset for ADC

Vignesh Raghavendra (2):
      dt-bindings: soc: ti: k3-ringacc: Describe cfg reg region
      arm64: dts: ti: k3: Add cfg reg region to ringacc node

 Documentation/devicetree/bindings/arm/ti/k3.yaml   |  13 +
 .../devicetree/bindings/crypto/ti,sa2ul.yaml       |  14 +-
 .../devicetree/bindings/soc/ti/k3-ringacc.yaml     |   9 +-
 arch/arm64/boot/dts/ti/Makefile                    |  19 +
 arch/arm64/boot/dts/ti/k3-am62-main.dtsi           |  52 +-
 arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi            |  24 +
 arch/arm64/boot/dts/ti/k3-am62-verdin-dahlia.dtsi  |  58 ++
 arch/arm64/boot/dts/ti/k3-am62-verdin-dev.dtsi     |  50 ++
 arch/arm64/boot/dts/ti/k3-am62-verdin-yavia.dtsi   |   5 +
 arch/arm64/boot/dts/ti/k3-am62-verdin.dtsi         |  45 +-
 arch/arm64/boot/dts/ti/k3-am62.dtsi                |   8 +
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts     | 154 +++-
 arch/arm64/boot/dts/ti/k3-am625-sk.dts             |   2 +-
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi          |  10 +-
 arch/arm64/boot/dts/ti/k3-am62a-mcu.dtsi           |  24 +
 arch/arm64/boot/dts/ti/k3-am62a7-sk.dts            |  35 +-
 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi          | 136 ++++
 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi           |  15 +
 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi        |  32 +
 arch/arm64/boot/dts/ti/k3-am62p.dtsi               | 122 +++
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts            | 116 +++
 arch/arm64/boot/dts/ti/k3-am62p5.dtsi              | 107 +++
 arch/arm64/boot/dts/ti/k3-am62x-sk-common.dtsi     |  93 ++-
 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso |  40 +
 arch/arm64/boot/dts/ti/k3-am64-main.dtsi           |  48 +-
 arch/arm64/boot/dts/ti/k3-am64-phycore-som.dtsi    |   1 +
 .../dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcard.dtso  |  22 +
 .../dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.dtso    |  22 +
 arch/arm64/boot/dts/ti/k3-am642-evm.dts            |   4 +-
 .../boot/dts/ti/k3-am642-phyboard-electra-rdk.dts  |   3 +-
 arch/arm64/boot/dts/ti/k3-am642-sk.dts             |   8 +-
 .../boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts    | 872 +++++++++++++++++=
++++
 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi     | 253 ++++++
 .../boot/dts/ti/k3-am65-iot2050-common-pg2.dtsi    |   2 +-
 arch/arm64/boot/dts/ti/k3-am65-iot2050-common.dtsi |   6 +-
 arch/arm64/boot/dts/ti/k3-am65-main.dtsi           |  35 +-
 arch/arm64/boot/dts/ti/k3-am65-mcu.dtsi            |  24 +-
 arch/arm64/boot/dts/ti/k3-am654-base-board.dts     |   5 +-
 .../boot/dts/ti/k3-am6548-iot2050-advanced-m2.dts  |   4 +-
 arch/arm64/boot/dts/ti/k3-am68-sk-base-board.dts   | 165 +++-
 arch/arm64/boot/dts/ti/k3-am69-sk.dts              |  12 +
 .../boot/dts/ti/k3-j7200-common-proc-board.dts     |  22 +-
 .../dts/ti/k3-j7200-evm-quad-port-eth-exp.dtso     |   2 +-
 arch/arm64/boot/dts/ti/k3-j7200-main.dtsi          |  23 +-
 arch/arm64/boot/dts/ti/k3-j7200-mcu-wakeup.dtsi    |  21 +-
 arch/arm64/boot/dts/ti/k3-j7200-som-p0.dtsi        |   1 +
 arch/arm64/boot/dts/ti/k3-j721e-beagleboneai64.dts |  63 +-
 .../boot/dts/ti/k3-j721e-common-proc-board.dts     |  42 +-
 .../boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso   | 196 +++++
 .../dts/ti/k3-j721e-evm-quad-port-eth-exp.dtso     |   2 +-
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi          |  48 +-
 arch/arm64/boot/dts/ti/k3-j721e-mcu-wakeup.dtsi    |  25 +-
 arch/arm64/boot/dts/ti/k3-j721e-sk.dts             |  60 +-
 arch/arm64/boot/dts/ti/k3-j721e-som-p0.dtsi        |  17 +-
 .../boot/dts/ti/k3-j721s2-common-proc-board.dts    |  88 ++-
 .../boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso  |  85 ++
 arch/arm64/boot/dts/ti/k3-j721s2-main.dtsi         | 192 ++++-
 arch/arm64/boot/dts/ti/k3-j721s2-mcu-wakeup.dtsi   |   9 +-
 arch/arm64/boot/dts/ti/k3-j721s2-som-p0.dtsi       |  15 +-
 arch/arm64/boot/dts/ti/k3-j784s4-evm.dts           |  91 ++-
 arch/arm64/boot/dts/ti/k3-j784s4-main.dtsi         |  41 +-
 arch/arm64/boot/dts/ti/k3-j784s4-mcu-wakeup.dtsi   |  18 +-
 arch/arm64/boot/dts/ti/k3-j784s4.dtsi              |   2 +
 arch/arm64/boot/dts/ti/k3-pinctrl.h                |  12 +
 arch/arm64/boot/dts/ti/k3-serdes.h                 | 204 +++++
 include/dt-bindings/mux/ti-serdes.h                |   8 +
 66 files changed, 3575 insertions(+), 381 deletions(-)
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-main.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-mcu.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p-wakeup.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62p5.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-am62x-sk-hdmi-audio.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-sdcar=
d.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am64-tqma64xxl-mbax4xxl-wlan.=
dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl-mbax4xxl.dts
 create mode 100644 arch/arm64/boot/dts/ti/k3-am642-tqma64xxl.dtsi
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721e-evm-gesi-exp-board.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-j721s2-evm-gesi-exp-board.dtso
 create mode 100644 arch/arm64/boot/dts/ti/k3-serdes.h
--=20
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5=
 849D 1736 249D

--lqjytuxbkvkshjzk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE+KKGk1TrgjIXoxo03bWEnRc2JJ0FAmTaURQACgkQ3bWEnRc2
JJ36sg//XmxknbIGJzM7jpFX1oDK8X2KmcVVbx5KrPuvpFeIi5AJEeBnHIaxmR7f
iV0MPsbmUCa/1rENTJMQ7mfUeMJBD6mIAnD1DmBX4XRJBk8dnIXlnMTC5Gw5O21r
LEQc5+CI1EqexbB++Rq7aQhpogadLFYcflJIaOjpAksUUO+RdCZwwTO7FqHCwnfI
IFKP3qdzVFZZ1R8fQ8pZlzVFIl5YgcVuIE4JB4DxVoZbPG2gPApV/mw+n6zB8PPu
s0FHH5K9RXwvyRAI+TVnJB8CX0goJ/I+jiUB+pfzZYcD2Wko7UQwPb/jcvd4jQgo
93WyJiEg0vmlq2aLlu3UtlqSCap5tQ096wlNdu0pW30WB84oeDrgCjpRypGcNocX
mnOKwOGZXMzkjvJzCz9xAAwkjRE7SigaupFDyDNvj97/Xio7js1UU1hwLUJ4ZPvk
BV31IqfOuRdzgwtg8S2/wvpH3ljorSfEFnt+LV4uTWSJX2Sk2lNuwvLJOkmV7fbF
zzgfyV47N8J/MhCitTJybGNREw62FxEhsUuTGopVo5+p0AZZ1nsbnCdgNIfZZfus
VqrYWUVTJ8gyh32dRJG8VHGoCZn5Y70+jyf1MeHTgbSRMAHBaD437m5KimdRyR/X
k2zFpqX+fJhNjUKpet+K0azHA8mlCT3qLz/eL+J0e0b1FyZa0m8=
=7JNl
-----END PGP SIGNATURE-----

--lqjytuxbkvkshjzk--

Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5546778963D
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 13:17:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjHZLQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 07:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232561AbjHZLQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 07:16:15 -0400
Received: from mx.skole.hr (mx2.hosting.skole.hr [161.53.165.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1172AA6;
        Sat, 26 Aug 2023 04:16:11 -0700 (PDT)
Received: from mx2.hosting.skole.hr (localhost.localdomain [127.0.0.1])
        by mx.skole.hr (mx.skole.hr) with ESMTP id 7AB1C833B0;
        Sat, 26 Aug 2023 13:16:08 +0200 (CEST)
From:   =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
Date:   Sat, 26 Aug 2023 13:15:52 +0200
Subject: [PATCH v2] arm: marvell: Fix maxium->maxim typo in brownstone dts
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230826-brownstone-typo-fix-v2-1-1f8196e9a2e3@skole.hr>
X-B4-Tracking: v=1; b=H4sIAOje6WQC/32NQQ7CIBBFr9LM2jFAoaIr72G6sHQqRAMNNGjTc
 HexB3D5XvLf3yBRdJTg0mwQKbvkgq8gDg0Ye/cPQjdWBsFEyzSTOMTw9mkJnnBZ54CT++CkBt4
 ZeRp1p6Au50hV79VbX9m6OojrfpL5z/7vZY4cpW7FqKVhip2v6RledLQR+lLKF9NWNnW1AAAA
To:     Lubomir Rintel <lkundrak@v3.sk>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Samuel Ortiz <sameo@linux.intel.com>,
        Qing Xu <qingx@marvell.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1307;
 i=duje.mihanovic@skole.hr; h=from:subject:message-id;
 bh=49t1UVPg2Rf9WsD0FkWFL7j0VQBEwi2PNjeKLJosF0c=;
 b=owEBbQKS/ZANAwAIAZoRnrBCLZbhAcsmYgBk6d718/XU0lY5w8yTymz1LpaNf7EY1BGPrCNP9
 OdVd262jeiJAjMEAAEIAB0WIQRT351NnD/hEPs2LXiaEZ6wQi2W4QUCZOne9QAKCRCaEZ6wQi2W
 4RW1D/9i7CptAgOahcAu7WLrn2unQzhi89dBqSJRUPebZowFzlxRAaayCBQ0COHm7QDnt7whXOw
 le5d2rb9dyPX3+v3qk0QdufuvNP3902GY0Yco2yQrt45vT4SLiBC8ZBK6ZJaVYeMVROypEfZwkU
 mWHT4/V40Lj6B1Y26la6duahJZON+0A6d+pI6jSPp1gGtYM061Bs2zhnYO6rYk8fICNKuLFkNnC
 EkneOmnW2OvcxL8TK4U+MatXnW0QFHyD+wJ4ClLd0QSnN1+F3nZhSh2qlvFmcRcwF9PQwajYneW
 fwO8BWWIbevROQTrDtNz2JkXJJ6J5E83S5gv4h/z8Gzul7muE/3z+I2QzY993ezicb80lPBkpfV
 9U5ZUjcawtrWp4g4mskTe8wGDj+OwAjhkI1QQPOvMPjNfUjcCTdVjQs10yNVeGzw2+OnnonO4MH
 Su7ZxQVxAc6WkvRjnpn+QOHLQvlodFzBAZLQL3kbRDabC2fJDJ6xQ6KfKjB0wcVONwtxnjLx1zy
 n5QqGgqHiuUkVmUyTpP+qjs6tH9qpzobDyen7pgTy6oXlek3fava7u4BEaCAzf/THg2byEaL82Z
 YSN7Pr85C1fD4SHsPuEaviJxm391DHuuzVyDtnHMeQCm28/d2grLik3jwpqbFowrqTmRoMLF9S8
 J3CUZbPK3kfwQ8g==
X-Developer-Key: i=duje.mihanovic@skole.hr; a=openpgp;
 fpr=53DF9D4D9C3FE110FB362D789A119EB0422D96E1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix an obvious spelling error in the PMIC compatible in the MMP2
Brownstone DTS file.

Without this, the PMIC would never probe.

Fixes: 58f1193e6210 ("mfd: max8925: Add dts")
Cc: stable@vger.kernel.org
Signed-off-by: Duje Mihanović <duje.mihanovic@skole.hr>
---
Changes in v2:
- Address maintainer comments:
  - Add Fixes: and Cc: tags
- Change "for" to "in" in subject
- Emphasize PMIC's inability to probe without patch
- Link to v1: https://lore.kernel.org/r/20230804-brownstone-typo-fix-v1-1-4832d84c0509@skole.hr
---
 arch/arm/boot/dts/marvell/mmp2-brownstone.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
index 04f1ae1382e7..bc64348b8218 100644
--- a/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
+++ b/arch/arm/boot/dts/marvell/mmp2-brownstone.dts
@@ -28,7 +28,7 @@ &uart3 {
 &twsi1 {
 	status = "okay";
 	pmic: max8925@3c {
-		compatible = "maxium,max8925";
+		compatible = "maxim,max8925";
 		reg = <0x3c>;
 		interrupts = <1>;
 		interrupt-parent = <&intcmux4>;

---
base-commit: 2ccdd1b13c591d306f0401d98dedc4bdcd02b421
change-id: 20230804-brownstone-typo-fix-f5b16c47d865

Best regards,
-- 
Duje Mihanović <duje.mihanovic@skole.hr>



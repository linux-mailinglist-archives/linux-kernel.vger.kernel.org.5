Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5923A77535C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 08:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231334AbjHIG7f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 02:59:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbjHIG7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 02:59:32 -0400
X-Greylist: delayed 1201 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 23:59:32 PDT
Received: from mx0b-002bf204.pphosted.com (mx0b-002bf204.pphosted.com [205.220.172.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1588519BC;
        Tue,  8 Aug 2023 23:59:31 -0700 (PDT)
Received: from pps.filterd (m0207525.ppops.net [127.0.0.1])
        by mx0a-002bf204.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 3794XkT3008020;
        Tue, 8 Aug 2023 23:39:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        monolithicpower.com; h=from:to:cc:subject:date:message-id
        :content-type:content-transfer-encoding:mime-version; s=pps1;
         bh=PVgDAh533IF8A1V/gz7z2rt2KqDkLxlapAP43n6ZwH0=; b=eyja0Ayeqfk1
        74i0/0Bj77wPGlE68KO/MaB86rMfxolz1yEXayFeec3vM9MfVSuqZlPJgLohNu7I
        0j3vhj+RB37Cdb3nvHYJU1daY6UU1Y9PW8EmppGHlCc1EkPj3Il9EgF3ad8pbxmi
        w++nZt639GwpbksaIafMWvbiLc8sdEmzA3WKCgKOU1AP+6i9awBnEktG3beZZbc+
        rw582Dfw1DktkfR6VmfuQsxnZGOCgEZZj/fz5riBClAhVDsQZcpfDQnSwesepnq9
        rqpM77r5p1UMMr/Qw9mDRHQhnly+0ULZs6RZzFftEjJUj+uT8ZESuHzS3XiqUIIa
        LC1XLA8Pjg==
Received: from webmail.monolithicpower.com (mps-mslbn02.monolithicpower.com [12.192.228.33])
        by mx0a-002bf204.pphosted.com (PPS) with ESMTPS id 3s9k3ycru3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 08 Aug 2023 23:39:16 -0700 (PDT)
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 mps-mslbn02.monolithicpower.com (10.10.10.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Tue, 8 Aug 2023 23:39:14 -0700
Received: from CD-MSH04.monolithicpower.com (10.10.70.213) by
 CD-MSH04.monolithicpower.com (10.10.70.213) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.4; Wed, 9 Aug 2023 14:39:12 +0800
Received: from CD-MSH04.monolithicpower.com ([fe80::fd9c:129e:f4d1:923f]) by
 CD-MSH04.monolithicpower.com ([fe80::fd9c:129e:f4d1:923f%4]) with mapi id
 15.01.2242.004; Wed, 9 Aug 2023 14:39:12 +0800
From:   "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>
To:     "pavel@ucw.cz" <pavel@ucw.cz>, "lee@kernel.org" <lee@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>,
        "Yuxi (Yuxi) Wang" <Yuxi.Wang@monolithicpower.com>,
        "wyx137120466@gmail.com" <wyx137120466@gmail.com>,
        "Leal (Long) Li" <Leal.Li@monolithicpower.com>
Subject: [PATCH 2/2] dt-bindings: leds: add mp3326
Thread-Topic: [PATCH 2/2] dt-bindings: leds: add mp3326
Thread-Index: AdnKikmg3hkiMAssTrO1eGgOEih83Q==
Date:   Wed, 9 Aug 2023 06:39:12 +0000
Message-ID: <fb09088db71f45169739addbaae770be@monolithicpower.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.84.38]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Proofpoint-GUID: BM0EgNcdq1SQ8RnN06o4QNonQnqSchKw
X-Proofpoint-ORIG-GUID: BM0EgNcdq1SQ8RnN06o4QNonQnqSchKw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_04,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0 phishscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 mlxscore=0 impostorscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308090058
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dt-bindings for Monolithic Power System MP3326.

Signed-off-by: Yuxi Wang <Yuxi.Wang@monolithicpower.com>
---
 .../devicetree/bindings/leds/leds-mp3326.yaml | 99 +++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/leds-mp3326.yaml

diff --git a/Documentation/devicetree/bindings/leds/leds-mp3326.yaml b/Docu=
mentation/devicetree/bindings/leds/leds-mp3326.yaml
new file mode 100644
index 000000000000..3a059340b902
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/leds-mp3326.yaml
@@ -0,0 +1,99 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/leds-mp3326.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: LED driver for MP3326 from Monolithic Power Systems.
+
+maintainers:
+  - Yuxi Wang <Yuxi.Wang@monolithicpower.com>
+
+description: |
+  Bindings for the Monolithic Power Systems MP3326 LED Drivers.
+
+  For more product information please see the link below:
+    https://www.monolithicpower.com/en/products/mp3326.html
+properties:
+  compatible:
+    const: MPS,MP3326
+
+  reg:
+    description: I2C slave address of the controller.
+    maxItems: 1
+
+  led-protect:
+    description: LED short protection threshold.
+    enum:
+      - 0 #2V
+      - 1 #3V
+      - 2 #4V
+      - 3 #5V
+
+  switch_status:
+    description: Master switch for all channels.
+    enum:
+      - 0 #close all channels
+      - 1 #open all channels
+
+patternProperties:
+  "^rgb(-[0-9a-f]+)?$":
+    description: RGB group.
+    type: object
+    unevaluatedProperties: false
+    properties:
+      rgb_r:
+        description: Red light of the RGB group.
+        maxItems: 16
+        minItems: 1
+      rgb_g:
+        description: Green light of the RGB group.
+        maxItems: 16
+        minItems: 1
+      rgb_b:
+        description: Blue light of the RGB group.
+        maxItems: 16
+        minItems: 1
+      brightness:
+        description: Brightness of the RGB group.
+        maxItems: 63
+        minItems: 0
+      required:
+        - rgb_r
+        - rgb_g
+        - rgb_b
+        - brightness
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+examples:
+  - |
+    #include <dt-bindings/leds/common.h>
+    MP3326@30 {
+        compatible =3D "mps,MP3326";
+        reg =3D <0x30>;
+        led-protect =3D<3>;
+        switch_status=3D<1>;
+
+        /*RGB group 1*/
+        rgb1@0{
+            rgb_r=3D<1>;
+            rgb_g=3D<2>;
+            rgb_b=3D<3>;
+            brightness=3D<30>;
+        };
+
+        /*RGB group 2*/
+        rgb2@1{
+            rgb_r=3D<7>;
+            rgb_g=3D<8>;
+            rgb_b=3D<9>;
+            brightness=3D<30>;
+        };
+    };
+
+
+...
--=20
2.25.1


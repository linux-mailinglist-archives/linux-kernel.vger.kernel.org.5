Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CCFC77E007
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 13:10:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbjHPLKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 07:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244246AbjHPLJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 07:09:59 -0400
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C81BDA;
        Wed, 16 Aug 2023 04:09:57 -0700 (PDT)
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37GABlaE020579;
        Wed, 16 Aug 2023 07:09:35 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3se7hu7brs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 07:09:35 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 37GB9Yg4011002
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Aug 2023 07:09:34 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 16 Aug 2023 07:09:33 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Wed, 16 Aug 2023 07:09:32 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Wed, 16 Aug 2023 07:09:32 -0400
Received: from ubuntu.ad.analog.com ([10.48.65.222])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 37GB9Dxi027589;
        Wed, 16 Aug 2023 07:09:26 -0400
From:   Ana-Maria Cusco <ana-maria.cusco@analog.com>
To:     <ana-maria.cusco@analog.com>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2]  dt-bindings: iio: hmc425a: add entry for HMC540S
Date:   Wed, 16 Aug 2023 14:09:06 +0300
Message-ID: <20230816110906.144540-2-ana-maria.cusco@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816110906.144540-1-ana-maria.cusco@analog.com>
References: <20230816110906.144540-1-ana-maria.cusco@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: IcGGJDINUSgPi8y4pSp0T-Gj6HzIYooJ
X-Proofpoint-GUID: IcGGJDINUSgPi8y4pSp0T-Gj6HzIYooJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-16_09,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 malwarescore=0 mlxscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2306200000 definitions=main-2308160099
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for HMC540SLP3E broadband 4-bit Silicon IC digital
attenuator with a 15 dB control range and wide frequency coverage
(0.1 to 8 GHz).

Signed-off-by: Ana-Maria Cusco <ana-maria.cusco@analog.com>
---
 .../bindings/iio/amplifiers/adi,hmc425a.yaml         | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
index 9fda56fa49c3..2ee6080deac7 100644
--- a/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
+++ b/Documentation/devicetree/bindings/iio/amplifiers/adi,hmc425a.yaml
@@ -4,20 +4,26 @@
 $id: http://devicetree.org/schemas/iio/amplifiers/adi,hmc425a.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: HMC425A 6-bit Digital Step Attenuator
+title: Analog Devices HMC425A and similar Digital Step Attenuators
 
 maintainers:
   - Michael Hennerich <michael.hennerich@analog.com>
 
 description: |
-  Digital Step Attenuator IIO device with gpio interface.
+  Digital Step Attenuator IIO devices with gpio interface.
+  Offer various frequency and attenuation ranges.
   HMC425A 0.5 dB LSB GaAs MMIC 6-BIT DIGITAL POSITIVE CONTROL ATTENUATOR, 2.2 - 8.0 GHz
-  https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
+    https://www.analog.com/media/en/technical-documentation/data-sheets/hmc425A.pdf
+
+  HMC540S 1 dB LSB Silicon MMIC 4-Bit Digital Positive Control Attenuator, 0.1 - 8 GHz
+    https://www.analog.com/media/en/technical-documentation/data-sheets/hmc540s.pdf
+
 
 properties:
   compatible:
     enum:
       - adi,hmc425a
+      - adi,hmc540s
 
   vcc-supply: true
 
-- 
2.34.1


Return-Path: <linux-kernel+bounces-120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB2F813C6B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 22:16:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37A6728104F
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 21:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D576A359;
	Thu, 14 Dec 2023 21:16:23 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtprelay07.ispgateway.de (smtprelay07.ispgateway.de [134.119.228.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62D6282E8;
	Thu, 14 Dec 2023 21:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=apitzsch.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=apitzsch.eu
Received: from [92.206.191.209] (helo=note-book.lan)
	by smtprelay07.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96.1)
	(envelope-from <git@apitzsch.eu>)
	id 1rDsoi-0002FX-21;
	Thu, 14 Dec 2023 22:00:25 +0100
From: =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>
Subject: [PATCH v2 0/2] ARM: dts: qcom: msm8926-motorola-peregrine: Add
 initial device tree
Date: Thu, 14 Dec 2023 21:59:32 +0100
Message-Id: <20231214-peregrine-v2-0-a35102268442@apitzsch.eu>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIALRse2UC/03MQQ7CIBCF4as0sxYDQ5pYV97DdAE4lNnQBlqiN
 txdbFy4/F9evh0yJaYM126HRIUzz7EFnjpwwcSJBD9aA0rUCuVFLJRoShxJDBKNRW/R+R7af0n
 k+XlY97F14LzO6XXQRX3Xn6L0n1KUkKJHHAiVdUb7m1l4fWcXzrTBWGv9AM1tnfakAAAA
To: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org, 
 ~postmarketos/upstreaming@lists.sr.ht, 
 =?utf-8?q?Andr=C3=A9_Apitzsch?= <git@apitzsch.eu>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Df-Sender: YW5kcmVAYXBpdHpzY2guZXU=

This dts adds support for Motorola Moto G 4G released in 2013.

Add a device tree with initial support for:

- GPIO keys
- Hall sensor
- SDHCI
- Vibrator

Signed-off-by: André Apitzsch <git@apitzsch.eu>
---
Changes in v2:
- Make clear it's about Moto G 4G released in 2013.
- Add a-b to patch 1/2.
- Combine nodes for gpio-keys.
- Link to v1: https://lore.kernel.org/r/20231213-peregrine-v1-0-5229e21bca3f@apitzsch.eu

---
André Apitzsch (2):
      dt-bindings: arm: qcom: Add Motorola Moto G 4G (2013)
      ARM: dts: qcom: msm8926-motorola-peregrine: Add initial device tree

 Documentation/devicetree/bindings/arm/qcom.yaml    |   1 +
 arch/arm/boot/dts/qcom/Makefile                    |   1 +
 .../dts/qcom/qcom-msm8926-motorola-peregrine.dts   | 291 +++++++++++++++++++++
 3 files changed, 293 insertions(+)
---
base-commit: 11651f8cb2e88372d4ed523d909514dc9a613ea3
change-id: 20231208-peregrine-902ab2fb2cf5

Best regards,
-- 
André Apitzsch <git@apitzsch.eu>



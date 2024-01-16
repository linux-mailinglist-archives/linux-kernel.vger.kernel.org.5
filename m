Return-Path: <linux-kernel+bounces-27283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF2A82ED3F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3F91F245D9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 10:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0302F1A5BB;
	Tue, 16 Jan 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="NDzcmQYF"
Received: from mail.fris.de (unknown [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D930E1A710;
	Tue, 16 Jan 2024 10:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 3E4F7C0391;
	Tue, 16 Jan 2024 11:53:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1705402420; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=AxZxHpQEvn1cc1E25a0FLjNNuCWaQYr9WWO94SlKprY=;
	b=NDzcmQYFYFA/qCLoH7W4f12xRZ5tgRIN5B8Hw4Fnd78LGOCRTzQuK1zUygnuET3UFael6d
	jKfhMsevzkI4NVjg4iRUEWOUpHsy2pYF/kM8wlx9DeB+gme8OVWlmQd3QlmOWWshs7lbNY
	DE2tsc6aMpso/xBx4/XAYq5cz+EpcNUSx644fDH2/tTjfEkR4t2KR24rMGR5Mz0WFI7Vrz
	kcJlWUIdhcPy9PnD9EnQUXFe6W9t8SvWhmIbukPKSpFO8GootmaEDWg47LNEcXIBdPxn40
	CR/Jjv29Csl5h6HwDhIhgN+TGV8Klk1eynFL/elRDLlV8z1rH3Vi/W6+0x+tTA==
From: Frieder Schrempf <frieder@fris.de>
To: Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	linux-kernel@vger.kernel.org,
	Rob Herring <robh+dt@kernel.org>
Cc: Frieder Schrempf <frieder.schrempf@kontron.de>,
	Chris Morgan <macromorgan@hotmail.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH 1/3] dt-bindings: vendor-prefixes: Add Sielaff
Date: Tue, 16 Jan 2024 11:51:55 +0100
Message-ID: <20240116105317.267525-2-frieder@fris.de>
In-Reply-To: <20240116105317.267525-1-frieder@fris.de>
References: <20240116105317.267525-1-frieder@fris.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

From: Frieder Schrempf <frieder.schrempf@kontron.de>

Add "Sielaff GmbH & Co. KG Automatenbau Herrieden" (https://sielaff.de).

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 309b94c328c84..8825a9f60ac5a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1233,6 +1233,8 @@ patternProperties:
     description: Si-En Technology Ltd.
   "^si-linux,.*":
     description: Silicon Linux Corporation
+  "^sielaff,.*":
+    description: Sielaff GmbH & Co. KG Automatenbau Herrieden
   "^siemens,.*":
     description: Siemens AG
   "^sifive,.*":
-- 
2.43.0



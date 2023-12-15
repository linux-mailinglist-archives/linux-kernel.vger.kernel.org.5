Return-Path: <linux-kernel+bounces-1657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 125638151A6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 22:10:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 968BA2866DB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 21:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C1647F7F;
	Fri, 15 Dec 2023 21:10:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E17D4778B;
	Fri, 15 Dec 2023 21:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i53875b61.versanet.de ([83.135.91.97] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rEFS2-0005kk-Q2; Fri, 15 Dec 2023 22:10:30 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Rob Herring <robh+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Trevor Woerner <twoerner@gmail.com>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] arm64: rockchip: dts: rk3328-rock-pi-e: add gpio-line-names
Date: Fri, 15 Dec 2023 22:10:27 +0100
Message-Id: <170267443961.1167098.2865099267527144228.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213160556.14424-1-twoerner@gmail.com>
References: <20231213160556.14424-1-twoerner@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Wed, 13 Dec 2023 11:05:55 -0500, Trevor Woerner wrote:
> Add names to the pins of the general-purpose expansion header as given
> in the Radxa GPIO page[1] following the conventions in the kernel
> documentation[2] to make it easier for users to correlate the pins with
> functions when using utilities such as 'gpioinfo'.
> 
> 

Applied, thanks!

[1/1] arm64: rockchip: dts: rk3328-rock-pi-e: add gpio-line-names
      commit: 799637dfadb092d1732afacea42f67a6f1621fb4

I've indented the gpio lines by one tab as suggested by Dragan.
And also moved the &gpio {} references to their correct position
in the file.

Please sort phandle-references alphabetically and not just add them
to the bottom of the file.


Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


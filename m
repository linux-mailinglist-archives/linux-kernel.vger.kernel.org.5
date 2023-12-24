Return-Path: <linux-kernel+bounces-10812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BBA81DC33
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 20:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D04751F2163D
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Dec 2023 19:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3822DF6D;
	Sun, 24 Dec 2023 19:54:57 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A75CDDB3;
	Sun, 24 Dec 2023 19:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sntech.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sntech.de
Received: from i5e86193c.versanet.de ([94.134.25.60] helo=phil.lan)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rHUYk-0006HY-SB; Sun, 24 Dec 2023 20:54:50 +0100
From: Heiko Stuebner <heiko@sntech.de>
To: Hugh Cole-Baker <sigmaris@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Heiko Stuebner <heiko@sntech.de>,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: Support poweroff on NanoPC-T6
Date: Sun, 24 Dec 2023 20:54:47 +0100
Message-Id: <170344745822.2405994.12076780121215785589.b4-ty@sntech.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216212134.23314-1-sigmaris@gmail.com>
References: <20231216212134.23314-1-sigmaris@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Sat, 16 Dec 2023 21:21:34 +0000, Hugh Cole-Baker wrote:
> The RK806 on the NanoPC-T6 can be used to power on/off the whole board.
> Mark it as the system power controller.
> 
> 

Applied, thanks!

[1/1] arm64: dts: rockchip: Support poweroff on NanoPC-T6
      commit: c699fbfdfd54630fc51b96da577f02e7b772eb37

Best regards,
-- 
Heiko Stuebner <heiko@sntech.de>


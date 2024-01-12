Return-Path: <linux-kernel+bounces-24895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B502882C458
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 18:10:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5151F21DBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 17:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553D56EB52;
	Fri, 12 Jan 2024 17:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9/29jY0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7AF1B5B4;
	Fri, 12 Jan 2024 17:10:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55D8C433F1;
	Fri, 12 Jan 2024 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705079428;
	bh=J8EmLdQ/1/m3S7gyBmJxGeYiyqMV6DiPtlNY9gPWH2A=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=J9/29jY0MyJHIr6R3YaMHUUzxxfbDtn80Kp7xNsPy6BMjeXMFL20shqgFZKqwAfOn
	 Dl3LExE6VbrrtEA8eJfUbPwNhChaWmuLR5Zr1/nBgiCYLasu3ry3t7gEYr00Rxd2ci
	 oM9ogHMolmTmW7Z8KblQHalbqFpBeTxFHyoogHjuxWbDxchgvrZuYjs7kPraTlOneQ
	 UOvNqwvTUCdJnwz3duop/vIe03zZXDBEeaJPtVJ2BDH2gGg/Jc5NNv0cLGcGFQND6b
	 3ntUjECojX5WViqh+J9X9jyx5JDQJMS7CnatcAWctzORlh9K1/7Rb8RpByWgMfPiW3
	 IArfDWRjD2aIQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 1/2] wifi: wilc1000: fix declarations ordering
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240105075733.36331-2-alexis.lothore@bootlin.com>
References: <20240105075733.36331-2-alexis.lothore@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-kernel@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170507942460.1153005.2140035185991203433.kvalo@kernel.org>
Date: Fri, 12 Jan 2024 17:10:26 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Reorder parameters declaration in wilc_parse_join_bss_param to enforce
> reverse christmas tree
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

2 patches applied to wireless-next.git, thanks.

535733e90e5d wifi: wilc1000: fix declarations ordering
205c50306acf wifi: wilc1000: fix RCU usage in connect path

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240105075733.36331-2-alexis.lothore@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



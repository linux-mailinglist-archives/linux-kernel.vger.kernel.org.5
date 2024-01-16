Return-Path: <linux-kernel+bounces-27552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF77882F20F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F18521C2369F
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8334F1C6BA;
	Tue, 16 Jan 2024 16:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aJTgUX3e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC131C686;
	Tue, 16 Jan 2024 16:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6C670C433B1;
	Tue, 16 Jan 2024 16:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705420829;
	bh=VR0zelLUhCaJCX6Q+iJZSRg5efDI4Ll3fVjKY9C1snQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aJTgUX3e6/A0yIlhhnIzOStguN5+R3jHPTRwWftJgervl+iM1z2yHGabqqGT1j2Mv
	 2P6SmQjA051ZSnNdrioIU3vevkkKIgEqy/iCojZ9L5Rkp/Yhbt5PvPK1Do2f1IbNNS
	 flX5Iu78NYp86thTPRzU55uTeEq6IG6mwgxGGV7WrSSavmlyXsrJGJsJgwbRBQdRBz
	 PcZ9A36paB2fGPTblj4Dz0KZdVL+jID2szHxSPqqweV1ipt6CURIHcTbn4KKDFUX+O
	 76XDwNwpk6qIW0b1aKfvKWiD8Tyj5MoEG6v923rtEb3My7HNZmYGPk66BSYhoBI7w0
	 Q2ZaYsB0+3COg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53407D8C987;
	Tue, 16 Jan 2024 16:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] Bluetooth: btusb: Add new VID/PID 13d3/3602 for MT7925
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170542082933.25552.3927828232982053152.git-patchwork-notify@kernel.org>
Date: Tue, 16 Jan 2024 16:00:29 +0000
References: <800469f157c862bcdef7213793004d2de977791f.1705129502.git.deren.wu@mediatek.com>
In-Reply-To: <800469f157c862bcdef7213793004d2de977791f.1705129502.git.deren.wu@mediatek.com>
To: =?utf-8?b?RGVyZW4gV3UgKOatpuW+t+S7gSkgPERlcmVuLld1QG1lZGlhdGVrLmNvbT4=?=@codeaurora.org
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 sean.wang@mediatek.com, chris.lu@mediatek.com, aaron.hou@mediatek.com,
 steve.lee@mediatek.com, linux-bluetooth@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 ulrik@strid.tech, deren.wu@mediatek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Sat, 13 Jan 2024 15:27:38 +0800 you wrote:
> From: Ulrik Strid <ulrik@strid.tech>
> 
> Add VID 13d3 & PID 3602 for MediaTek MT7925 USB Bluetooth chip.
> 
> The information in /sys/kernel/debug/usb/devices about the Bluetooth
> device is listed as the below.
> 
> [...]

Here is the summary with links:
  - Bluetooth: btusb: Add new VID/PID 13d3/3602 for MT7925
    https://git.kernel.org/bluetooth/bluetooth-next/c/eaab5c300eab

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




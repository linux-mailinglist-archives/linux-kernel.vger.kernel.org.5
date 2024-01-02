Return-Path: <linux-kernel+bounces-14667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CB82822084
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 18:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34629283E9F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1285156F5;
	Tue,  2 Jan 2024 17:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KaQDTxtU"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E4A154AC;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 90048C433CA;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704217253;
	bh=VxMdNNMyuaTRdjeIZFjpLo8mLdtWd29apFbxWK+iGZ8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KaQDTxtU4W5zlUE8qXxhIYqROI2R47Kg47jVO7aPUkQ7tk474W66F8xHPwNq3dZf+
	 Yw2KriWTxJgheWNW2W/0FAiqqakdJ37XB4s3CDTdLzx2E4Xz+tIQV+bZealKQUb/t9
	 IyYpNFcLj5yNidlo+75jMj8PBA0zQprEWStsp4rOVNuavNf+j+Y7OQ3lUVvsTdejY/
	 adhiVdkPJkgyBE1ttG9ffPBk6inMfv8dY5G1hPtl/TFqpatyYu0zhqib+oQk7+4GUH
	 zeflEWJwvSyP8iTVmjwd6Dd277h8POoBmC0w7HS2ar2iJtIMPoz3+RmL79ttFZPQoJ
	 uP+ZkIQPdoeWQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6EAAADCB6D0;
	Tue,  2 Jan 2024 17:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] Bluetooth: btrtl: Add the support for
 RTL8852BT/RTL8852BE-VT
From: patchwork-bot+bluetooth@kernel.org
Message-Id: 
 <170421725344.27590.6759141188493326496.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 17:40:53 +0000
References: <20231226114518.5395-1-max.chou@realtek.com>
In-Reply-To: <20231226114518.5395-1-max.chou@realtek.com>
To: Max Chou <max.chou@realtek.com>
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 alex_lu@realsil.com.cn, hildawu@realtek.com, karenhsu@realtek.com

Hello:

This patch was applied to bluetooth/bluetooth-next.git (master)
by Luiz Augusto von Dentz <luiz.von.dentz@intel.com>:

On Tue, 26 Dec 2023 19:45:17 +0800 you wrote:
> From: Max Chou <max.chou@realtek.com>
> 
> Add the support for RTL8852BT/RTL8852BE-VT BT controller on USB interface.
> The necessary firmware will be submitted to linux-firmware project.
> 
> The device info from /sys/kernel/debug/usb/devices as below.
> 
> [...]

Here is the summary with links:
  - [v2] Bluetooth: btrtl: Add the support for RTL8852BT/RTL8852BE-VT
    https://git.kernel.org/bluetooth/bluetooth-next/c/8f9bb7a1b81b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




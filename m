Return-Path: <linux-kernel+bounces-16548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1154382400A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E5AF285F64
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 11:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791EA210F2;
	Thu,  4 Jan 2024 11:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BtHk/0LB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7C020DE2;
	Thu,  4 Jan 2024 11:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 87A2FC433C7;
	Thu,  4 Jan 2024 11:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704366025;
	bh=381JDdfjF2Y9oQEt2wb3RWM+90u9wPsOLkJMGW1dW2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BtHk/0LBFwHWhvRKK6kFigxB//0rgvtTZ6qYWv+TE2tk1jjswpAPEma5753pBfmiC
	 JyPiOoaa+tBUf/didtcrwMShSv8JTzz7tHFtmPPFaLz5trNg4r29QiQo5Vrg6EUgC3
	 LK9Dw6qswv7DQ7oGGO7QxcntuKqt7avGkw/RVSDKR7vb+HxXnpTFDrsF/bTyiMfQ1x
	 VRp9kbOPZdCEcir0v4b9m7SRI+ZYSM67SUtAHsqOoKlsfexyTcmIUNkzrHw52q3oAA
	 fMtZaZbK7jPq7fUloD8a5sSofMEM6fLgGHvd4sbVu+wM1CRQ8m+4lu22taogb+Nqjk
	 7fjRrbwD+uPRg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6CF7EC3959F;
	Thu,  4 Jan 2024 11:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] asix: Add check for usbnet_get_endpoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170436602544.13188.3749207110557059321.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jan 2024 11:00:25 +0000
References: <20240103033534.2764386-1-nichen@iscas.ac.cn>
In-Reply-To: <20240103033534.2764386-1-nichen@iscas.ac.cn>
To: Chen Ni <nichen@iscas.ac.cn>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, christian.riesch@omicron.at, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  3 Jan 2024 03:35:34 +0000 you wrote:
> Add check for usbnet_get_endpoints() and return the error if it fails
> in order to transfer the error.
> 
> Fixes: 16626b0cc3d5 ("asix: Add a new driver for the AX88172A")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/usb/ax88172a.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Here is the summary with links:
  - asix: Add check for usbnet_get_endpoints
    https://git.kernel.org/netdev/net/c/eaac6a2d26b6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




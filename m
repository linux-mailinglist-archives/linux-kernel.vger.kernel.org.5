Return-Path: <linux-kernel+bounces-14440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD09F821D16
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 14:50:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067C41F22879
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jan 2024 13:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B601095C;
	Tue,  2 Jan 2024 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsDvRiD9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 565FB12B65;
	Tue,  2 Jan 2024 13:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D6507C433CA;
	Tue,  2 Jan 2024 13:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704203430;
	bh=QzdG3qDbAXwKUvB4DivjxUtsn8i2Wp8lrwdZKDx1LQQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tsDvRiD9SI/JNhphrVQDJg4tuyPRLkb3ODK/ZNHdo5N1zUdR7cOItxWBpNXUpaUU8
	 Vygh0rOReNsRHJgiN0JBibiQZHiwjaqxK6xDGpSY/6GtniPz3HigfhhEJjxbiO35YE
	 EkW9Y2JRtjscOta/0CPfZ29uhst/O2knVnt1Wiz7oqeUjKgBZju/koZ8/Obed5r74E
	 b4tJ0uPeskVWHIV81bT1Ehivv3CItN6kgVgXc50LbaialMl3T1tvWefMBuTfL8TFzO
	 CNdslKvtb6UilEhmj5Dj2nt9GtI62wRCctDLP1Hql9bmfIiY9AJp+NgCrn4hrry2+J
	 ZQD15kCjpHjUw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B9253DCB6D1;
	Tue,  2 Jan 2024 13:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] Documentation: add pyyaml to requirements.txt
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170420343075.29739.11859606241625033278.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jan 2024 13:50:30 +0000
References: <20231222133628.3010641-1-vegard.nossum@oracle.com>
In-Reply-To: <20231222133628.3010641-1-vegard.nossum@oracle.com>
To: Vegard Nossum <vegard.nossum@oracle.com>
Cc: kuba@kernel.org, netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, leitao@debian.org, davem@davemloft.net,
 corbet@lwn.net

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 22 Dec 2023 14:36:28 +0100 you wrote:
> Commit f061c9f7d058 ("Documentation: Document each netlink family") added
> a new Python script that is invoked during 'make htmldocs' and which reads
> the netlink YAML spec files.
> 
> Using the virtualenv from scripts/sphinx-pre-install, we get this new
> error wen running 'make htmldocs':
> 
> [...]

Here is the summary with links:
  - [net-next] Documentation: add pyyaml to requirements.txt
    https://git.kernel.org/netdev/net-next/c/7df54188a897

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html




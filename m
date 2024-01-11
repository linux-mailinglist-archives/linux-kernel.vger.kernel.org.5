Return-Path: <linux-kernel+bounces-23662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30AE82AFC6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E8E528971D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9884182DC;
	Thu, 11 Jan 2024 13:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OU681YG8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D715EB9;
	Thu, 11 Jan 2024 13:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430A5C433F1;
	Thu, 11 Jan 2024 13:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704980175;
	bh=6/U0ODNJBNYX+WErisuDi9d/DTO/O/ktEPokR1uh/Ls=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OU681YG8PC8jgd7JccnuO9u2ULxC7onfs4ibu6C+hev2EqDEDiUC6HKzUFTiCoZ5S
	 3wfUn9iHy29qkMGDXCanmQ7HBnKHWGhX1YYSS+GS61wFgSntA3ekc+Bs64HwXAQzT6
	 SLNoBJL3wuC6Amn8roXXvDeKo/7xfGPzZRikdlHz2ejbaCDkZ6GlHy+42phz5MUqrQ
	 BTrTRYA6TgyDFoTlfzu/19UDbUQmfw1VE6SRkcBzCRZI3tOi9PoZX8F5BsRCJDfdD2
	 brWfYl9EBWTavPHIWoVSXIpV18iAiNfOng5lp9Iqh7M08InK/nBQ5iOrrVhHpPP8py
	 PBPT302QjeHpg==
Date: Thu, 11 Jan 2024 13:36:09 +0000
From: Simon Horman <horms@kernel.org>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wintera@linux.ibm.com, wenjia@linux.ibm.com, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	jaka@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
	alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 00/15] net/smc: implement loopback-ism used by
 SMC-D
Message-ID: <20240111133609.GC45291@kernel.org>
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240111120036.109903-1-guwen@linux.alibaba.com>

On Thu, Jan 11, 2024 at 08:00:21PM +0800, Wen Gu wrote:
> This patch set acts as the second part of the new version of [1] (The
> first part can be referred from [2]), the updated things of this version
> are listed at the end.

..

Hi Wen Gu,

unfortunately net-next is currently closed.

[adapted from text by Jakub]

## Form letter - net-next-closed

The merge window for v6.8 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens on or after 21st January.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
--
pw-bot: defer


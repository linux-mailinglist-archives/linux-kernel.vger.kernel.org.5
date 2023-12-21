Return-Path: <linux-kernel+bounces-8196-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F5881B374
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:24:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E99CE1F252B2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5204F8B4;
	Thu, 21 Dec 2023 10:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FrBQJNS3"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB474E1B5
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 10:24:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4F5DC433C8;
	Thu, 21 Dec 2023 10:24:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703154278;
	bh=QCbtTmWIw0DjINy2fQ6yKWwqkb2U97QfoGHbOnp13eQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FrBQJNS323bxLb3XW8mhMIjwUoOApjsq1wmxLE6TnQjk5bzTydxttgkMrYrrXreBH
	 0IPDAkbTGGLHYpYP8UHt2Jd2ydfFh2PiPnxsUvUGhB5VVcbdrWo0oZsvg/vHfZi7pa
	 FccCdD4hM5ue5WEJmEz2ZB586GejYNWNpVIJ1EOE=
Date: Thu, 21 Dec 2023 11:24:35 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [GIT PULL] w1: drivers for v6.8
Message-ID: <2023122128-spider-emblem-388c@gregkh>
References: <20231221101602.15826-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221101602.15826-1-krzysztof.kozlowski@linaro.org>

On Thu, Dec 21, 2023 at 11:16:02AM +0100, Krzysztof Kozlowski wrote:
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-w1.git tags/w1-drv-6.8

Pulled and pushed out, thanks.

greg k-h


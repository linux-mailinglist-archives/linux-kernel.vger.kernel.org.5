Return-Path: <linux-kernel+bounces-15992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C73D8236AF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C144A2833EC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:38:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29A91D54E;
	Wed,  3 Jan 2024 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoUlmvSd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EBD1D545;
	Wed,  3 Jan 2024 20:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AEAC433C8;
	Wed,  3 Jan 2024 20:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704314331;
	bh=KXCarQeUSf3ykVxs442GxKIpArocGiwYtdGgdX+mzIo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EoUlmvSd6br3I69wjPY1GYiAN647kL1Hh1mTIv6AiWEMhp/yUJwH3irP9ctDseUfs
	 PKvR4oZN+S/Wt9iog1+v+Ab8xtiA2yuqwHzc0FFcf/WATdFYobDjrT9u1ct4AE9Gqf
	 BiPd+SeC10OkexBMDe2J+nVJTgbj7N5DNBeaLuRevViWDxG/Gh17zH9mFB+dNSNkv0
	 LRHef/czx3VEChj8Rk3uwwiSywk3B3nSnO80zeAN5d2d1O5KQchrv/ExMGww5tfTU2
	 N0sRh0yDhmr9LUSmTf5GVw2Dr9I6p8hvC1cmjzigUj7iTmkmox0ZBeMlti3HNDCjeC
	 mOpKz4P1FyT2w==
Received: (nullmailer pid 1721140 invoked by uid 1000);
	Wed, 03 Jan 2024 20:38:49 -0000
Date: Wed, 3 Jan 2024 13:38:49 -0700
From: Rob Herring <robh@kernel.org>
To: Muhammad Muzammil <m.muzzammilashraf@gmail.com>
Cc: devicetree@vger.kernel.org, robh+dt@kernel.org, linux-kernel@vger.kernel.org, frowand.list@gmail.com
Subject: Re: [PATCH] drivers: of: Fixed kernel doc warning
Message-ID: <170431432287.1720975.15667716273289262607.robh@kernel.org>
References: <20231219062317.17650-1-muzammil@dreambigsemi.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219062317.17650-1-muzammil@dreambigsemi.com>


On Tue, 19 Dec 2023 11:23:17 +0500, Muhammad Muzammil wrote:
> From: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
> 
> property.c:1220 : Fixed excess struct member definition warning
> property.c:444 	: Fixed missing a blank line after declarations
> 
> Signed-off-by: Muzammil Ashraf <m.muzzammilashraf@gmail.com>
> ---
>  drivers/of/property.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Applied, thanks!



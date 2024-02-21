Return-Path: <linux-kernel+bounces-75325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5A85E695
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25C9C287D24
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5104B8593E;
	Wed, 21 Feb 2024 18:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4a49GRx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901A484A45;
	Wed, 21 Feb 2024 18:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708541240; cv=none; b=pQL+gVd/SMtI4JWwCRVGIzo51P7thm56eu1F4d5Y8XilmqjWu+qZKAY9TOsIJHtDbRzFPqBtt8AvAoLC7Z8Iw2poEy0CtQ8cVXc11mL8xjegVFuE1PE9AFJnk9niApvVSw0rOmYDAoGuuIQrJ7J2Ik4CTsyakgjbP0zog+abXv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708541240; c=relaxed/simple;
	bh=gqoAm28ysMhQcEAAi5Gh3dH2gq6BWAr+ceiJbrjqTLw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=fne7kmEVu1cvCJOZ8jr8hs89iUAU4DLVKKyhywzxFgptUQQzQ1Ku5ddt88ep/0af+sgHEhbkwv3C61Ypbsj7xb8gWJ6azieABtF5IJJLYjBhX/eL6SoPX+pSBDonOszFpT7C6q45NjYfZ6g3zcjB2D/yvs2aCNkS98hKmymLwOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4a49GRx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60FE2C433F1;
	Wed, 21 Feb 2024 18:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708541240;
	bh=gqoAm28ysMhQcEAAi5Gh3dH2gq6BWAr+ceiJbrjqTLw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=B4a49GRxpgPJI2ECisO/VeUOxKUutVCrIW4oXYFeemxKREmjO4ZIBHQwmxTMuu7ir
	 yWvYvDsaJBjexF4S7mUZpUOzTsS4NBr+uTRcHfInbw1OBtpPytvT6RIXETNCb5mO2/
	 /ChAOFz+Ta+Fw2oFV9YNv+LwyTnbZtw/mLHJtUuZ5PP04y9iCQvrqGuxGNCIlA0gef
	 iva8GpSCKQ3C9EX70Hz6GpvLL090bHj3ALKDJizvIKsbiisDEGG+77r7Srefr+nnCL
	 4xQNz+H+8cDIc+jFSuE4U2l+Td9+nXv6AFe2X8YOiD1eUFTSKDOrEmViJtR+l1tAhL
	 Ns/2jC9pyTBgQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [1/2] MAINTAINERS: wifi: update Jeff Johnson e-mail address
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240217-update-maintainer-v1-1-1426cf7a8bb1@quicinc.com>
References: <20240217-update-maintainer-v1-1-1426cf7a8bb1@quicinc.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: <ath10k@lists.infradead.org>, <ath11k@lists.infradead.org>,
 <ath12k@lists.infradead.org>, <devicetree@vger.kernel.org>,
 <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170854123612.1848588.403515299525075943.kvalo@kernel.org>
Date: Wed, 21 Feb 2024 18:47:18 +0000 (UTC)

Jeff Johnson <quic_jjohnson@quicinc.com> wrote:

> I now have a @kernel.org e-mail address, so use that for my
> maintenance activities.
> 
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

2 patches applied to wireless.git, thanks.

27dc4c6ee5fe MAINTAINERS: wifi: update Jeff Johnson e-mail address
1b7d9ab3e666 MAINTAINERS: wifi: Add N: ath1*k entries to match .yaml files

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240217-update-maintainer-v1-1-1426cf7a8bb1@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches



Return-Path: <linux-kernel+bounces-8871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BF81BD72
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 18:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90F161C22DCB
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA4634E1;
	Thu, 21 Dec 2023 17:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmhgXh/E"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAD7627F4;
	Thu, 21 Dec 2023 17:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F97C433C8;
	Thu, 21 Dec 2023 17:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703180440;
	bh=cJRJia0H10o+aBvcQG5xPpIzftIQUfu6g1hofp+Ojh4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jmhgXh/ET/xqCYBUAAkEMvlIxdVb9zkNdwolhxjml0dhYpXMavG6pVF7wgnPG6MhK
	 5VpRdXBU9avsQbJRB2ukqGk1Tt0oyXZ39F+DaL2bK1auPmWTMXjxAqWVga6vZHG7uR
	 tM0g8q5+PCQWk0qKBmvNG2zF5M7hFFEyvyS2bgF00mPVynLXC2IkMu8sy8Kq8lfXEN
	 66DaEQIY7i4j2e/OqzZ420MRr/pEwitxM/J3fQHFgEGq1xacep6vK6h0hW0M4I6WdF
	 H+54jLR6ejVkbOS1Z3+3F8ZxiaWRELG9JwtfmEfHbhCiYJnthKOIco+7NYCoLVQUAf
	 XRn2EhTLoRm5w==
Date: Thu, 21 Dec 2023 18:40:34 +0100
From: Simon Horman <horms@kernel.org>
To: YouHong Li <liyouhong@kylinos.cn>
Cc: isdn@linux-pingi.de, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, k2ci <kernel-bot@kylinos.cn>
Subject: Re: [PATCH] drivers/isdn/hardware/mISDN/w6692.c: Fix spelling typo
 in comment
Message-ID: <20231221174034.GC1202958@kernel.org>
References: <20231221024758.1317603-1-liyouhong@kylinos.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221024758.1317603-1-liyouhong@kylinos.cn>

On Thu, Dec 21, 2023 at 10:47:58AM +0800, YouHong Li wrote:
> From: liyouhong <liyouhong@kylinos.cn>
> 
> Fix spelling typo in comment.
> 
> Reported-by: k2ci <kernel-bot@kylinos.cn>
> Signed-off-by: liyouhong <liyouhong@kylinos.cn>

Thanks,

while we are updating this file could we also fix the following
which is flagged by codespell: oscilator ==> oscillator

With that update feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>


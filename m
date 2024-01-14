Return-Path: <linux-kernel+bounces-25482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E020182D0E9
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 15:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791591F21695
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 14:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED4323C6;
	Sun, 14 Jan 2024 14:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRArPb4R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3330F2570;
	Sun, 14 Jan 2024 14:34:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79AF5C433F1;
	Sun, 14 Jan 2024 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705242846;
	bh=EszImnKYJnEnKFk1wt073gthk8M6xM7ENBGQn/T0edM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YRArPb4RPBK5ot3z0ZMSvwVELOPnXJAKuuuJj9y66aWMPRrNCtvXuxwYfTIi7G5eD
	 C1FHSsamBbHNJeu3dMT/fYJXcbaTcofAAP6gYcV3adLquCsCXqxQs0kse1ALhluIIO
	 It0E4jdkX8FSI78tOaSAy8mv2M1JIXUv2sXPZVxRBuTxxQabC8jwuOnjv+fAgm/jxE
	 h9sqSe+9jF4gkFSBFm1a3sLN6iVmiX9WTU33xgknss7HFnQF1gXfY3ohSJIInIgTTL
	 9hhF/Fl5RUTeIWp8ucrBo4SeNSfQnlWN6wAvvq4nJH5aj/9BZGtY4CVmfFqAQCR4cC
	 N4P5HOW9L59sA==
Date: Sun, 14 Jan 2024 09:34:05 -0500
From: Sasha Levin <sashal@kernel.org>
To: David Airlie <airlied@redhat.com>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Dave Airlie <airlied@gmail.com>, kherbst@redhat.com,
	lyude@redhat.com, dakr@redhat.com, daniel@ffwll.ch,
	bskeggs@redhat.com, dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: Re: [PATCH AUTOSEL 6.1 5/5] nouveau: fix disp disabling with GSP
Message-ID: <ZaPw3WAmT2OwHY98@sashalap>
References: <20240108122823.2090312-1-sashal@kernel.org>
 <20240108122823.2090312-5-sashal@kernel.org>
 <CAMwc25rAm1ndSiofWMMmQ1BeB0XxBvsHpcvaDKXUwEZp72iwEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAMwc25rAm1ndSiofWMMmQ1BeB0XxBvsHpcvaDKXUwEZp72iwEA@mail.gmail.com>

On Tue, Jan 09, 2024 at 06:51:25AM +1000, David Airlie wrote:
>NAK for backporting this to anything, it is just a fix for 6.7

Dropped it from everywhere, thanks!

-- 
Thanks,
Sasha


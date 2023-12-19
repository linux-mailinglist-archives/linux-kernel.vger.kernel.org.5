Return-Path: <linux-kernel+bounces-4847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7AF8182CE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DDFC2870F1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2089134D3;
	Tue, 19 Dec 2023 07:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JyDqsij2"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6BC12E73
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B539C433CB;
	Tue, 19 Dec 2023 07:58:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702972707;
	bh=JL3MhY4UqSb4GZDryZkhIdBsrnfYRT97W7lvoyLslcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JyDqsij2y+x3k0jOkS4ukrOd+0vbRqOEqEN8Ss3+vYsNomJBkKX1iHvPJ3+3nLOrQ
	 nPtebB7G10JeSK1L1ai0YdED/QnlbhpYISI50TQJDXYjdPzD6LKBXq23g3fYcP9i1X
	 GihSzD/lmTMFmCth9yU3XWOtplYfz+Jdr44O/aIY=
Date: Tue, 19 Dec 2023 08:58:25 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chanwoo Choi <chanwoo@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [GIT PULL] extcon next for 6.8
Message-ID: <2023121917-caucasian-figurine-7ea1@gregkh>
References: <fee142e1-ac58-477f-b8d7-51e108dddbf6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fee142e1-ac58-477f-b8d7-51e108dddbf6@kernel.org>

On Tue, Dec 19, 2023 at 07:40:27AM +0900, Chanwoo Choi wrote:
> Dear Greg,
> 
> This is extcon-next pull request for v6.8. I add detailed description of
> this pull request on below. Please pull extcon with following updates.
> 
> Best Regards,
> Chanwoo Choi
> 
> 
> The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:
> 
>   Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/extcon.git tags/extcon-next-for-6.8

Pulled and pushed out, thanks.

greg k-h


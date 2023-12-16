Return-Path: <linux-kernel+bounces-2307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E8F815ACC
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B552D286386
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D92F328CB;
	Sat, 16 Dec 2023 17:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TLp8+xVJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D29A831A6C;
	Sat, 16 Dec 2023 17:48:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 146C8C433C8;
	Sat, 16 Dec 2023 17:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702748919;
	bh=P1kzaczI5wG5FLX1+c3J+k8vP55QBzgSdkJ2DdjzDt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TLp8+xVJxXoYlQSwlgIODG0GgDfZiJanI5Hk8VwaK87/93eV/Is29YmAKA+Vol8rk
	 zW2MmEGFoHy+sffOmyzl6lbhektMXKTzSxAiJuFO1efXp7fXdoA27k+QII5EGsuYbZ
	 zd5qrEw4iRDO/HBqqNTWWlGcTxR5OpKW/XlWwlk/dP+MTI8S0m7xq1VXFhnkXIXLcG
	 KRh9KCqCe6RpTrqzp4IVVlFDxXLW394EuJ3OhrCQUSezWiQD8PXrGr8vFL8s+IC73F
	 IT02cG5QtfnWavNb2GE95LFYBkZcOq3K52TuREHi5abr9z7PGda825UiU0gJCAPFQ3
	 fSFtPOxNgYH8Q==
Date: Sat, 16 Dec 2023 17:48:33 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	shenjian15@huawei.com, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v6 2/4] octeon_ep: PF-VF mailbox version support
Message-ID: <20231216174833.GQ6288@kernel.org>
References: <20231215181425.2681426-1-srasheed@marvell.com>
 <20231215181425.2681426-3-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215181425.2681426-3-srasheed@marvell.com>

On Fri, Dec 15, 2023 at 10:14:23AM -0800, Shinas Rasheed wrote:
> Add PF-VF mailbox initial version support
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>



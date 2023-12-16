Return-Path: <linux-kernel+bounces-2308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F43815ACE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 18:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 527731F23DCD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 17:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7619B315B4;
	Sat, 16 Dec 2023 17:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fBVrC6QC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8229328A7;
	Sat, 16 Dec 2023 17:48:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230B9C433C7;
	Sat, 16 Dec 2023 17:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702748936;
	bh=702Jj1ETQ2hbwrunIypgBskPOQv14k5kWPHbUrIHThc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fBVrC6QCdRoRck1oj/z69iOVTGYHhavfmc8KTde8xf5QChr3ftKaF+/9SB5QagxxX
	 Z6ZQLvpSjx0Vgn/UqdngJujkEXMlj8IDLvrT0XsQd8DvIwhalysYdNBVd358t+sWi2
	 aw8MtFjcwHJdPunK7qNR9Cdu0NZgn67iDFu+XIr460JUMXntzdc8VN8739Obo2zsTp
	 fAvPsOmY/a0BmyQ4RSaIdstdkGor8DG6zZtizeWF1lbpPkfarTtKtKu1sx7/Xy9wNP
	 OyPCnVP0j8u7jGyipUymAPiOeb51xveJT7mei0Cw2uAmbsSisuuC6y2TMrbqpAHtlf
	 QFG/d/7x2iBig==
Date: Sat, 16 Dec 2023 17:48:50 +0000
From: Simon Horman <horms@kernel.org>
To: Shinas Rasheed <srasheed@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, hgani@marvell.com,
	vimleshk@marvell.com, egallen@redhat.com, mschmidt@redhat.com,
	pabeni@redhat.com, kuba@kernel.org, davem@davemloft.net,
	wizhao@redhat.com, kheib@redhat.com, konguyen@redhat.com,
	shenjian15@huawei.com, Veerasenareddy Burru <vburru@marvell.com>,
	Sathesh Edara <sedara@marvell.com>,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next v6 3/4] octeon_ep: control net framework to
 support VF offloads
Message-ID: <20231216174850.GR6288@kernel.org>
References: <20231215181425.2681426-1-srasheed@marvell.com>
 <20231215181425.2681426-4-srasheed@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215181425.2681426-4-srasheed@marvell.com>

On Fri, Dec 15, 2023 at 10:14:24AM -0800, Shinas Rasheed wrote:
> Inquire firmware on supported offloads, as well as convey offloads
> enabled dynamically to firmware for the VFs. Implement control net API
> to support the same.
> 
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>

Reviewed-by: Simon Horman <horms@kernel.org>



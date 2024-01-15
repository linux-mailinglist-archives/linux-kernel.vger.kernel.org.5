Return-Path: <linux-kernel+bounces-26049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D592882DA79
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 14:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83DD028136A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 13:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8531755A;
	Mon, 15 Jan 2024 13:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fuNyR5pg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BDD717543;
	Mon, 15 Jan 2024 13:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105C3C433F1;
	Mon, 15 Jan 2024 13:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705326390;
	bh=mW3bDPk7kAfD9Tl2yOCKQXmbyk/P+fGp/f70qYInYbc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fuNyR5pgjVO+iKSvCrGn7ggQNzTYHL30j7vfVCUhX2uphzjL0WkYrEcxa760o1TqN
	 5F8OOMTTssOI/uIMbgCsqC+K3ASTxvL2Z8Pcdz6CZTdBXz2zkNyRew6S+NeeA99hmn
	 dDJ9ERnz8sCo8eVIlDPqs1nW4VROMxCA6jhIzSID6W+NqM6mgkQ/9TQEHc2oZF3Rwq
	 q+wiCz/Udoss6KtZvGIdGI+dqzGEpemAnZvFcpk4kpDjAFUn7iZ9osBAB9av+AhEcX
	 qZt3jUzyEy0ynz0zVPbSVxAUpJ5aXLKodmfq96TVFQDuZEISSyyaOESFzhr59VmHtS
	 7QY019cL/hpCQ==
Date: Mon, 15 Jan 2024 13:46:25 +0000
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
	Ying Xue <ying.xue@windriver.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH] tipc: socket: remove Excess struct member kernel-doc
 warning
Message-ID: <20240115134625.GA431715@kernel.org>
References: <20240112050020.27109-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112050020.27109-1-rdunlap@infradead.org>

On Thu, Jan 11, 2024 at 09:00:20PM -0800, Randy Dunlap wrote:
> Remove a kernel-doc description to squelch a warning:
> 
> socket.c:143: warning: Excess struct member 'blocking_link' description in 'tipc_sock'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>



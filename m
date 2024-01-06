Return-Path: <linux-kernel+bounces-18696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64E35826133
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 20:08:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0405A1F221C6
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jan 2024 19:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E44AF4E4;
	Sat,  6 Jan 2024 19:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZYi4m4t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C024E549;
	Sat,  6 Jan 2024 19:07:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A580FC433C8;
	Sat,  6 Jan 2024 19:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704568070;
	bh=zWynsKb/SiXuFdVAnbWgtFsh2AcTQtELMGzqTUSlExc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GZYi4m4t+jMzMSLoUKFzVzF20hsfGfPk60Fb6djUmG7tpl5lPrm4C6QnamZgfaP7L
	 7MRcOm/TE6uW3xaRx5xVuXHNkWh/jHUC5P6T/S6A+a5cB6Sxcb+PwfxgbWMz1vKmG9
	 yVF7cgpKTP9hhUwiKxj0bmwv0DcfKTLnoWvOIaTIMrfqcZPK5Ml44uVSDUGpzV1BSr
	 yztbiRsEoV38UE8J8cWB+XN4GLANQ1/NOflfhdMY1sgtnaJscghVTCLXkIbJqt/6Rz
	 FERhbBweMkQTfRjZa8E+IyiyYwd+ELCMx1fS1MZXUkz1vpokA6saa08ZIE5BpGjvLL
	 QrIK/bT7m55uQ==
Date: Sat, 6 Jan 2024 19:07:45 +0000
From: Simon Horman <horms@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	alexis.lothore@bootlin.com, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 1/2 net-next] ipvlan: Fix a typo in a comment
Message-ID: <20240106190745.GF31813@kernel.org>
References: <5adda8a3ce7af63bc980ba6b4b3fbfd6344e336b.1704446747.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5adda8a3ce7af63bc980ba6b4b3fbfd6344e336b.1704446747.git.christophe.jaillet@wanadoo.fr>

On Fri, Jan 05, 2024 at 10:27:08AM +0100, Christophe JAILLET wrote:
> s/diffentiate/differentiate/
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Thanks,

this looks good to me.
And it appears this was the only spelling error that
codespell sees in this file.

Reviewed-by: Simon Horman <horms@kernel.org>


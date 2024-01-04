Return-Path: <linux-kernel+bounces-16703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F018242B0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BCC2286B16
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3722337;
	Thu,  4 Jan 2024 13:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hkywFs6C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F3F12230B;
	Thu,  4 Jan 2024 13:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E6C433C7;
	Thu,  4 Jan 2024 13:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704375153;
	bh=yryV1LkCvfh+SCadTXL3yX8IjcIp50ZsAxug4hgqzBU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hkywFs6C3vBtIUxlAA/lHtYDgt8WakfHKJzP+f20U1N5AwYZtzej2cevueDCnCwY9
	 JmUbEhhATTtMntbfqWCPsdWj9Uz2hlfeZ9N0+Uti7zQZxpPj7KKRMSWsMgPRVZZAmu
	 v+hae3twCiFE5zYVFYXbPCzJLCdM9r8ptycl0Wiw=
Date: Thu, 4 Jan 2024 14:32:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: phanirajkiran <phanirajkiran.a@gmail.com>
Cc: Prathu Baronia <prathubaronia2011@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Yangtao Li <frank.li@vivo.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fixes alignment should match open
 parenthesis
Message-ID: <2024010401-deputize-occupant-cb6f@gregkh>
References: <20231226110459.6816-1-phanirajkiran.a@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231226110459.6816-1-phanirajkiran.a@gmail.com>

On Tue, Dec 26, 2023 at 04:34:58PM +0530, phanirajkiran wrote:
> This patch fixes the checks reported by checkpatch.pl
> for alignment should match open parenthesis
> 
> Signed-off-by: phanirajkiran <phanirajkiran.a@gmail.com>

To be sure, is this the name you use for identification?  Just one word?

thanks,

greg k-h


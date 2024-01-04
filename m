Return-Path: <linux-kernel+bounces-16780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BB08243A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 15:23:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B62A4281EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 14:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337AA22EFA;
	Thu,  4 Jan 2024 14:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hOrWABVi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F3225D8;
	Thu,  4 Jan 2024 14:22:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCAE1C433C7;
	Thu,  4 Jan 2024 14:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704378153;
	bh=2qqhvq3RrW4BNPclBTyDKYe5e0kRLBcC56fvPQzT7dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hOrWABVijsgmr5c1Ol/m5DI2oloASUCWO4TymwhyQhXhkrrF2o+PA9RYhOpuZiZ5B
	 mQJKRoGzhRGQxT6L9wcXKGVT4f7S5qcVb83FdyeDolH9xYgSbJheHFn6CY8hkkSOcu
	 6Jn4an3K1X/+k6PtV+V0thaQ1e3ssxVVPmM684Ng=
Date: Thu, 4 Jan 2024 15:22:30 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Phanirajkiran <phanirajkiran.a@gmail.com>
Cc: Prathu Baronia <prathubaronia2011@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Yangtao Li <frank.li@vivo.com>,
	Khadija Kamran <kamrankhadijadj@gmail.com>,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: fixes alignment should match open
 parenthesis
Message-ID: <2024010418-navy-grandpa-dc0e@gregkh>
References: <20231226110459.6816-1-phanirajkiran.a@gmail.com>
 <2024010401-deputize-occupant-cb6f@gregkh>
 <CAJEOW9YiuBSLUrP0BkRGQRmJWOKpB4Y=DhTGUnDDumhuzmcH1A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJEOW9YiuBSLUrP0BkRGQRmJWOKpB4Y=DhTGUnDDumhuzmcH1A@mail.gmail.com>

On Thu, Jan 04, 2024 at 07:40:32PM +0530, Phanirajkiran wrote:
> Yes, Greg. To keep it Simple.
> Regards,
> Phanirajkiran

Great, please resend with the capital letter fixed up :)

greg k-h


Return-Path: <linux-kernel+bounces-4730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A988C81814A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 07:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 568981F23205
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 06:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17DD747E;
	Tue, 19 Dec 2023 06:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XhCZa8ZG"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2221A125A8;
	Tue, 19 Dec 2023 06:02:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C936C433C8;
	Tue, 19 Dec 2023 06:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702965770;
	bh=v4h6wCw5j3Fz/E4Hy9UNse+L8g7fVs4DKBcEgFdSaG0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhCZa8ZGa9P+DaFrJFgKFjaUveJzH5Oe+313Ga2C77HOVHzOt0jkUFeTINj0NsrDy
	 6Z9RFM2O9IDIeMlMCo8KuD3psM4fjeoPgUBrziqsiZQKAnvCuQy3RtDD9UJPJknGau
	 na26W6pNLNRG+voP1pOPZT4O2z9gszXiPnSae8Gk=
Date: Tue, 19 Dec 2023 07:02:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Yinghua Yang Yang <yinghua.yang@motorolasolutions.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	zachary.zuzzio@motorolasolutions.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	Oliver Neukum <oneukum@suse.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Wentong Wu <wentong.wu@intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: misc: Add driver for Motorola Solutions security
 accessories
Message-ID: <2023121904-mace-tastiness-d502@gregkh>
References: <20231215211218.2313996-1-Yinghua.Yang@motorolasolutions.com>
 <26c70a69-f18f-4c82-a520-7943be0e1961@rowland.harvard.edu>
 <CAHhS5zZzHzZBADHkKyzCzr5FJ0zdTvsaQUE0ygjU1FG3vocrCA@mail.gmail.com>
 <2023121712-gigabyte-oppressed-b8f4@gregkh>
 <CAHhS5zY+X5DFX5cYir-raswc0Pmck-nuMSWAsK7epBU3ARO_BA@mail.gmail.com>
 <2023121805-knickers-apostle-1aa3@gregkh>
 <CAHhS5zYKLuFcPyiVXZmyomdZ71QOyKhfB+Y2ktyqPTvDF4GxTw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhS5zYKLuFcPyiVXZmyomdZ71QOyKhfB+Y2ktyqPTvDF4GxTw@mail.gmail.com>

On Mon, Dec 18, 2023 at 05:44:35PM -0600, Yinghua Yang Yang wrote:
> Not sure what happened to the email. I was just replying using gmail's web
> interface and did not do anything special.

Yes, and by default, gmail sends stuff in html format, which the mailing
lists reject, you will have to change that if you wish to participate in
kernel development, as the documentation describes.

thanks,

greg k-h


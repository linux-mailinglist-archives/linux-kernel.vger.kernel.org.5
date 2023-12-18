Return-Path: <linux-kernel+bounces-3061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1D38166CA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 07:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 791A0282AFB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 06:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F79747D;
	Mon, 18 Dec 2023 06:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="naP7Zg1M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18AE7460;
	Mon, 18 Dec 2023 06:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3704C433C8;
	Mon, 18 Dec 2023 06:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702882253;
	bh=NMtXgxOROOnAV4SpNmzhdKZGoDXsm5IRKSfAcn3eHtc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=naP7Zg1MnDxgAf/U6EnTZUDDcG+PYNt05jhEPlr8LZaDh4yvl3wTeL6w/43jJmb1r
	 F+s1EXlYqPEFGl0p8k6ZOMpk70Q+vy2xFYtCleAEr50j2rIEdAdnnCuPzAQTObxruj
	 +54xNRnQvL5cMdEDnm/3AYawza+p8nmgSF6OO5es=
Date: Mon, 18 Dec 2023 07:50:50 +0100
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
Message-ID: <2023121805-knickers-apostle-1aa3@gregkh>
References: <20231215211218.2313996-1-Yinghua.Yang@motorolasolutions.com>
 <26c70a69-f18f-4c82-a520-7943be0e1961@rowland.harvard.edu>
 <CAHhS5zZzHzZBADHkKyzCzr5FJ0zdTvsaQUE0ygjU1FG3vocrCA@mail.gmail.com>
 <2023121712-gigabyte-oppressed-b8f4@gregkh>
 <CAHhS5zY+X5DFX5cYir-raswc0Pmck-nuMSWAsK7epBU3ARO_BA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHhS5zY+X5DFX5cYir-raswc0Pmck-nuMSWAsK7epBU3ARO_BA@mail.gmail.com>

On Sun, Dec 17, 2023 at 09:56:34PM -0600, Yinghua Yang Yang wrote:

<snip>

For some reason you sent this in html format, which the mailing lists
reject, and you top-posted, making it hard to respond.  Please fix up
and resend so that everyone on the mailing lists can respond properly.

thanks,

greg k-h


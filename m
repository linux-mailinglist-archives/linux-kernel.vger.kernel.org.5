Return-Path: <linux-kernel+bounces-23406-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD5E82AC61
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 11:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD9E1C22752
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55609154A1;
	Thu, 11 Jan 2024 10:45:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y0rVHaaj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E04F1549E;
	Thu, 11 Jan 2024 10:45:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B788C433C7;
	Thu, 11 Jan 2024 10:45:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704969910;
	bh=otTxhAPvsRjqSlgmiFFIM6ilyM8UWcJKCMTo+H92XN8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Y0rVHaajgApriNuaWA17WZi171hNoFM5LJcggluyOYRxi/n6Mk5oWxp2Y4rUT2RaW
	 MAIwYGBIfjcz4bqyOqGeblCTavgPjPW4ARnQoL8Ssx4XdJgcUrnBQt0V6P11asRKxZ
	 n9qCPIYLSo0orM8T2OJVZNv2HykFEpud7NwhxR0s=
Date: Thu, 11 Jan 2024 11:45:07 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: stable@vger.kernel.org, Wander Lairson Costa <wander@redhat.com>,
	Dave Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	virtualization@lists.linux-foundation.org,
	spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	lvc-project@linuxtesting.org
Subject: Re: [PATCH 5.10 1/1] drm/qxl: fix UAF on handle creation
Message-ID: <2024011100-marsupial-outshine-e7f5@gregkh>
References: <20240109110827.9458-1-pchelkin@ispras.ru>
 <20240109110827.9458-2-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109110827.9458-2-pchelkin@ispras.ru>

On Tue, Jan 09, 2024 at 02:08:25PM +0300, Fedor Pchelkin wrote:
> From: Wander Lairson Costa <wander@redhat.com>
> 
> commit c611589b4259ed63b9b77be6872b1ce07ec0ac16 upstream.

Now queued up, thanks.

greg k-h


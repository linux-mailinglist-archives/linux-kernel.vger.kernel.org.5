Return-Path: <linux-kernel+bounces-20449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DCEE827F22
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46A141C235C8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 07:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7641D9468;
	Tue,  9 Jan 2024 07:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uZfthH+T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BB9444;
	Tue,  9 Jan 2024 07:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD054C433C7;
	Tue,  9 Jan 2024 07:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704784717;
	bh=bpP5aBUI9Jl6orKYoCdlf437/SigQrCw3q9Gju+8VJE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uZfthH+TYvqVWh5DSSbmE9Wdegiw/zpnnA8aTo41cwM3quebJf0EJwq89StU2Y/5T
	 T4pnb9Peip8KNxHBnQThGVBITazYJQH4ias+od9PDbha8iyVVEzIIElgEjiUn9JrtY
	 254yrDz/3bddDcSVoLz+oHo8XgpLFOZbN+Sq5EDs=
Date: Tue, 9 Jan 2024 08:18:34 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] staging: rtl8192e: rename variable cur_bw_40mhz
Message-ID: <2024010919-wand-footgear-80cb@gregkh>
References: <20240109033234.570-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109033234.570-1-garyrookard@fastmail.org>

On Mon, Jan 08, 2024 at 10:32:34PM -0500, Gary Rookard wrote:
> Changes from v3 include
> Rename from  millihertz(mhz) Megahertz(MHz)
> cur_bw_40mhz -> cur_bw_40MHz

This belongs below the --- line, not above it, right?

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-25454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34E82D07D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 13:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4B561C20C7E
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 12:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDDA2109;
	Sun, 14 Jan 2024 12:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ywNASAw7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D47720E4;
	Sun, 14 Jan 2024 12:23:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE6D7C433C7;
	Sun, 14 Jan 2024 12:23:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1705234992;
	bh=fhSTLYQJRW5x3RYDEWNWfkqUnSg0YQssLcGVosl6l9g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ywNASAw7jw+sybO/KBRJME/LdxEm9IDJ9NjFSIO/Yb/+2qzCTixYZG7aYa+StK0sv
	 QAKKO9MATo82rezbPtC3FSPPBAqnmlWV1DSrUuPbyjofl39FJkuhIQNTX4aESZTCwc
	 E0c/4GWYLe8suzcWF/Map3AZZmcLkymwEK19EKnk=
Date: Sun, 14 Jan 2024 13:23:09 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthias Yee <mgyee9@gmail.com>
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: fixed check alignment of open
 parenthesis in card.c
Message-ID: <2024011456-kindred-chewing-8650@gregkh>
References: <20240109063618.2810-1-mgyee9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109063618.2810-1-mgyee9@gmail.com>

On Mon, Jan 08, 2024 at 10:36:19PM -0800, Matthias Yee wrote:
> This patch adjusts whitespace to fix the checkpatch warning Alignment Should Match Open Parenthesis.

Please wrap your changelog at 72 columns.

thanks,

greg k-h


Return-Path: <linux-kernel+bounces-1500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F099814F6E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB771C21249
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DC230112;
	Fri, 15 Dec 2023 18:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PgZhzv06"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4EE30104;
	Fri, 15 Dec 2023 18:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC7DC433C7;
	Fri, 15 Dec 2023 18:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702663422;
	bh=aQlrhj7NGm30IUxIA61YrqyM0n8WujlBCDkVuTIvLXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PgZhzv06TEOARG8E0GG1jx9DLR4axd9b1oaICHSzvW4MpI+0aqed2qQPaDYieIeOg
	 6HYHWIq4BJvExAY2A3SyX1b9kaX3eX6/20GNg/Hmv7Ue2X5omrW8/vpXgU7hWBJG+8
	 b0OutyFv8VONiQw3TXiR4HCdda3XZIdD9MKlNmCU=
Date: Fri, 15 Dec 2023 13:03:41 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: users@linux.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: PSA: final vger mailing list migration: Thu, Dec 14, 11AM PST
 (1900 UTC)
Message-ID: <20231215-white-eagle-of-shopping-9bc2c3@lemur>
References: <20231212-unselfish-real-myna-67e444@lemur>
 <20231214-unbiased-modest-herring-12b6eb@meerkat>
 <20231214-snobbish-numbat-of-focus-46ab36@meerkat>
 <2023121504-postwar-skinny-4520@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2023121504-postwar-skinny-4520@gregkh>

On Fri, Dec 15, 2023 at 05:32:53PM +0100, Greg KH wrote:
> Thank you so much for doing this work, I know it hasn't been easy
> migrating one of the higest-volume mailing lists in the world with no
> interruptions.  If nothing else, you all should get a few conference
> talks about it, and free beer from all of us!

Thanks, Greg! I'll take you up on the free beer, but the technical aspects
weren't actually all that exciting. :) I will probably do a write-up over on
people.k.o over the holidays, for the general interest of what is probably 5-6
people out there actually interested in the gritty details. :)

Cheers,
-K


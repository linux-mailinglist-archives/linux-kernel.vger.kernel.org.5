Return-Path: <linux-kernel+bounces-23309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7225682AAD9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 10:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 969031C21731
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 09:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B8910A0C;
	Thu, 11 Jan 2024 09:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ymglk+mU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C740F10940;
	Thu, 11 Jan 2024 09:27:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CC8C433C7;
	Thu, 11 Jan 2024 09:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704965224;
	bh=LDdBXtXC1Q6CzekGGAaKheRuGxlH7OUhkHk4mOiLGk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ymglk+mUPZhjJyZ4VwEnOKMK1iE79L88gbGxtnSYOkvkQjcKK8YOeeiyTu5oPFwXA
	 Uv3VMyVLQJPs+ZPK50UrenbMMDTciUk5rKpl5fIXmPFHWVV47DZk3Mwd2aDnSEx/n6
	 qjmzp5iPBdoaxABxbY7OXJfg1WddUWGdHHO3kZ/w=
Date: Thu, 11 Jan 2024 10:27:01 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pranav Athreya <pranavsubbu@gmail.com>
Cc: Forest Bond <forest@alittletooquiet.net>, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: Remove extra blank lines between code
 blocks
Message-ID: <2024011144-sinister-baking-952d@gregkh>
References: <20240111070652.71717-1-pranavsubbu@gmail.com>
 <2024011144-silica-viral-9e79@gregkh>
 <CAP1Lp88vEZJtd69Njf9uZ5VXypwZ-5vLdBHf2xoLSpqmeyEQiA@mail.gmail.com>
 <CAP1Lp8-CP-uELVam=18oADOEvL_13wXkTyDLHKbjQe1ZyxiG9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP1Lp8-CP-uELVam=18oADOEvL_13wXkTyDLHKbjQe1ZyxiG9g@mail.gmail.com>

On Thu, Jan 11, 2024 at 02:39:54PM +0530, Pranav Athreya wrote:
> My apologies, resending this as plain text.
> 
> Greg,
> 
> Thank you for reviewing my patch! Shall I amend the commit and send a
> revision of the patch?

Yes, please read the kernel documentation for how to submit a new
version of a patch.

thanks,

greg k-h


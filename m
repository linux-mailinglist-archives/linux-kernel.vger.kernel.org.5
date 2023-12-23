Return-Path: <linux-kernel+bounces-10416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E1FA81D424
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6BE11F228BF
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFD2DDC2;
	Sat, 23 Dec 2023 13:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0ypF4w0t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3CE3DDA2;
	Sat, 23 Dec 2023 13:07:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62890C433C7;
	Sat, 23 Dec 2023 13:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703336836;
	bh=me91JwrsnCBw9P7tUZE/6vmKBCp1NxtcqiZmnFDViLs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0ypF4w0tfjAd/FItjstMf2iGSQUy4B3P7BZVKjZgEhigPJwrwA6ZQvKAFaute4GJU
	 IKfDxssITV6dmKOrLHJ1CzwfRrOUbO+pRlCfnS9PMabyb8zRLUHXCEJ7GZPwn0TCLt
	 AEmI1YrzUmqpWQ96Yi4YPMbeY0PgmN3XIT8zhCo4=
Date: Sat, 23 Dec 2023 14:07:10 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Gary Rookard <garyrookard@fastmail.org>
Cc: philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] staging: rtl8192e: rename variable pHT
Message-ID: <2023122348-angular-shopper-0b92@gregkh>
References: <20231216125303.3404-1-garyrookard@fastmail.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231216125303.3404-1-garyrookard@fastmail.org>

On Sat, Dec 16, 2023 at 07:52:59AM -0500, Gary Rookard wrote:
> Hi,
> 
> This patch series renames (4) different variables with
> checkpatch coding style issue Avoid CamelCase.
> 
> (resubmittals)

Does not apply to my tree :(

Please rebase against the correct branch?

thanks,

greg k-h


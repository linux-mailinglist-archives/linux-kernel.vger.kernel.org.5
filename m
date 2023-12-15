Return-Path: <linux-kernel+bounces-904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D634E8147CA
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2B91F22D18
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FB832D78A;
	Fri, 15 Dec 2023 12:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="uUnJgsCZ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 659AC2D04E
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 12:14:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E10AC433C7;
	Fri, 15 Dec 2023 12:14:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702642485;
	bh=Js6D3zIFVq3MfkI2hYEs00LsoAl93LzDm/QfxKqkTBc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=uUnJgsCZraLARFDXMXpBh1noBhVZgnz7nFTrVdZkWO5q4t2RLbgqUFhT6aOQ6YMym
	 mnKFXPsEKO1prHiVpeudrmXwBI1CmG5nfOVHzl2aQ5SMs3EprSvVtDZWm19pooS7un
	 b6YZMNzgU+wCC7J/wY+byG5GVmLsFMqaJo1fJdHc=
Date: Fri, 15 Dec 2023 13:14:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvmem: fixes for 6.7
Message-ID: <2023121533-oyster-cone-6d6d@gregkh>
References: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
 <2023121517-dwindle-feminism-1c7e@gregkh>
 <68f3f085-16a2-4065-ab72-c6ef22a47e6c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68f3f085-16a2-4065-ab72-c6ef22a47e6c@linaro.org>

On Fri, Dec 15, 2023 at 11:31:03AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 15/12/2023 11:26, Greg KH wrote:
> > On Fri, Dec 15, 2023 at 11:13:56AM +0000, srinivas.kandagatla@linaro.org wrote:
> > > From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > > 
> > > Hi Greg,
> > > 
> > > Here are two fixes in nvmem for 6.7, if its not too late could you queue
> > > these for next possible rc.
> > > 
> > > Thanks,
> > > Srini
> > > 
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=UTF-8
> > > Content-Transfer-Encoding: 8bit
> > > 
> > > *** BLURB HERE ***
> > 
> 
> Forgot to delete this.
> 
> > No blurb?
> 
>   ____  _     _    _ _____  ____
>  |  _ \| |   | |  | |  __ \|  _ \
>  | |_) | |   | |  | | |__) | |_) |
>  |  _ <| |   | |  | |  _  /|  _ <
>  | |_) | |___| |__| | | \ \| |_) |
>  |____/|______\____/|_|  \_\____/
> 
> :-)

Much better, thanks!  I'll go queue these up now :)


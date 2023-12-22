Return-Path: <linux-kernel+bounces-9389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1913581C4ED
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 07:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C143D1F24EDA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 06:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA188C19;
	Fri, 22 Dec 2023 06:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e0pPBtNA"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 218476FD2
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 06:13:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92A97C433C7;
	Fri, 22 Dec 2023 06:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1703225589;
	bh=s/QHQXGx0ESC1AU2NxdhEvj7Y4r/OC1fOae1mBtaxMk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e0pPBtNACiiZDtDCLctZnpPMM5KDV/PGtx5HM3S7OPiFXlIIh4TlPk9FqMX0ShWIR
	 5o87HGtiHb1LCr5tQfUy5LVuSi9hbiXYwJmuKn0b6F6wVEKVbWUzDybLv12F8lZMxo
	 gMcepWgg8b1qUaoiyLgWnhqF+KZqksOREhcTTDfI=
Date: Fri, 22 Dec 2023 07:13:07 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: "Gangurde, Abhijit" <abhijit.gangurde@amd.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Gupta, Nipun" <Nipun.Gupta@amd.com>,
	"Gupta, Puneet (DCG-ENG)" <puneet.gupta@amd.com>,
	"Agarwal, Nikhil" <nikhil.agarwal@amd.com>,
	"Simek, Michal" <michal.simek@amd.com>,
	"git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH v2 1/2] cdx: create sysfs bin files for cdx resources
Message-ID: <2023122236-consonant-prism-4a85@gregkh>
References: <20231123043907.4134256-1-abhijit.gangurde@amd.com>
 <DM4PR12MB776536C75B88E06507A976B08F94A@DM4PR12MB7765.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB776536C75B88E06507A976B08F94A@DM4PR12MB7765.namprd12.prod.outlook.com>

On Fri, Dec 22, 2023 at 05:35:44AM +0000, Gangurde, Abhijit wrote:
> > Subject: [PATCH v2 1/2] cdx: create sysfs bin files for cdx resources
> > 
> > Resource binary file contains the content of the memory regions.
> > These resources<x> devices can be used to mmap the MMIO regions in
> > the user-space.
> > 
> > Co-developed-by: Puneet Gupta <puneet.gupta@amd.com>
> > Signed-off-by: Puneet Gupta <puneet.gupta@amd.com>
> > Signed-off-by: Abhijit Gangurde <abhijit.gangurde@amd.com>
> > ---
> 
> Hi Greg,
> Could you please review this patch series?

It's not in my review queue anymore at all, if it's still needed, please
resend.

thanks,

greg k-hj


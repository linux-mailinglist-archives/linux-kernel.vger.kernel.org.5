Return-Path: <linux-kernel+bounces-834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 870438146D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:26:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43F4E282D5B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C0324B4A;
	Fri, 15 Dec 2023 11:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xuqYiNcF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26D6724B30
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:26:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41352C433C7;
	Fri, 15 Dec 2023 11:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1702639586;
	bh=Pu8q2J10rwOVcdW+9IB0xOr+XGcjqIXAozrc9/ikK4g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xuqYiNcFqlZQBU0HTYL4B/ir+HjTyFAWOa/tV3OFlvGeV96jmt3MHHq4mWdWTxWrQ
	 EkhP8ift1NG/5rySJVK2Pix0ljsYIWL66+Z7iSElwQVEJNCa4rNOtbNZO19U0hpoUT
	 VNp/Do6OzZsaV1zJ0TncvSKl6lqBJ4VBhbT2HUhg=
Date: Fri, 15 Dec 2023 12:26:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: srinivas.kandagatla@linaro.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] nvmem: fixes for 6.7
Message-ID: <2023121517-dwindle-feminism-1c7e@gregkh>
References: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215111358.316727-1-srinivas.kandagatla@linaro.org>

On Fri, Dec 15, 2023 at 11:13:56AM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Hi Greg, 
> 
> Here are two fixes in nvmem for 6.7, if its not too late could you queue
> these for next possible rc.
> 
> Thanks,
> Srini
> 
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> *** BLURB HERE ***

No blurb?


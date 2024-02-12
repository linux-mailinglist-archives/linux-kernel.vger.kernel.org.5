Return-Path: <linux-kernel+bounces-62494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 067688521A2
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACE3F28219E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2A74E1BD;
	Mon, 12 Feb 2024 22:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyQWWHQa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0112C4F889;
	Mon, 12 Feb 2024 22:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707777800; cv=none; b=nQr2GQTo18PmGqKTQc5vac9PTZwfGDW3VwoScXem2h+gZMhRmxaxeh+Rvu4vWw99BmEFCo/s8tGbFcL4ca2SDf1hjigLk08+ZsiTNlSahKMABgmFtftuQXsetgy095ppNOTOIOmwBu5FBKzqutDoM98Nkvw4w8MkZ81d5kcALhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707777800; c=relaxed/simple;
	bh=x2mMi/fx9SnRvghtCGTJEcD7mZ+U4vCfO/kAy4ITm8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZVoBNn/WlMMSeUNOyYX9NsRjI+1xQoWmSvPKMikZwJUFb+zf2Ddu0830R9A0dl/tV0ymW+HGBYTW0FIS91systzbr+8uoZ0nwdDH2unFFLgIQwkpx3/uSk44iaZwK/VJqnjWmPE8R7F7wPS4aW1/Bwy9i/+O3HN76X3XRzpruBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyQWWHQa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FAF9C433F1;
	Mon, 12 Feb 2024 22:43:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707777799;
	bh=x2mMi/fx9SnRvghtCGTJEcD7mZ+U4vCfO/kAy4ITm8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyQWWHQafzrMSy+PFMbNIlAtOPCP+JbIKLPlilmaTOZs7SegUA5XNyZQsexCR1xwp
	 wY9bB8fW5NB9Pk2QzYQ2LU82o7wcsEyTMu3rnqqWL33fi5rqkc7mqTXuavT8sVm/VR
	 QM++PBoO1qT//fuLwZLwc9XxCYZ9RMpkGur1fnq3pNDMZoDEeY56oXLFgfU1pS/QJf
	 +rMYG68S8q7Hp9BeFowp1jOfugLgrAfWI1TDbbcqC6t9Dn+9FPnoI42cGJUN9n1lKQ
	 FrDvpuihjceONJS4QVPKR5GLACt+RE47S2IyEU9PDQdm8Grn4V/vHQCCT3sDP3Sqws
	 Pi2dE41qavslQ==
Date: Mon, 12 Feb 2024 16:43:17 -0600
From: Rob Herring <robh@kernel.org>
To: Saravana Kannan <saravanak@google.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	kernel-team@android.com
Subject: Re: [PATCH] MAINTAINERS: of: Add Saravana Kannan
Message-ID: <170777778090.2688977.14804637560473102697.robh@kernel.org>
References: <20240210231513.111117-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240210231513.111117-1-saravanak@google.com>


On Sat, 10 Feb 2024 15:15:12 -0800, Saravana Kannan wrote:
> Adding myself as a second maintainer for Open Firmware and Device Tree
> to help Rob out with reviews and other maintainer work.
> 
> Cc: devicetree@vger.kernel.org
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---
> Discussed this with Rob.
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!



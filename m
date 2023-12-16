Return-Path: <linux-kernel+bounces-2355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C453815B87
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:04:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0CB921C218D2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC6CA328DA;
	Sat, 16 Dec 2023 20:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDaxXC4C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331FB3419A;
	Sat, 16 Dec 2023 20:04:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65259C433C7;
	Sat, 16 Dec 2023 20:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702757041;
	bh=aiWEHw3ltcJuIhTaPNa3SSo4iRfwoiVeTcGSw/UTXtM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDaxXC4CyP5PvCADunlVwcJhW24r+/4jL292CbJ3kBmQ01RQy0HXTmRdVdIkmCgC6
	 owb9QVhmVFNh9qZPpEm0COk0Vpitiy3acAQqEgfHbXj9v8GirnS5gFXFVZFXG6PSaF
	 lQ1RjDwZGTfMDxmBs7qWo2F51Qu1Z7+P+OX/YaHNB7uGj6FFPJ07YphDGMsKh2m6Kb
	 mTAL5k+7Cy5ts/FkUS//aYOagjKpd2Ni8AGL/v3mpGSTI5n6JfM19/VczRMNglLkVG
	 VtV0Fmz7H6KPICbphAzG1guRnVtOx6WaUyV4BtEUf+0TfkzlINVDfa7EvYkMtp7/j6
	 AXchtBgvaeRWg==
Date: Sat, 16 Dec 2023 20:03:56 +0000
From: Simon Horman <horms@kernel.org>
To: deepakx.nagaraju@intel.com
Cc: joyce.ooi@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH 3/5] net: ethernet: altera: move read write functions
Message-ID: <20231216200356.GU6288@kernel.org>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
 <20231213071112.18242-4-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213071112.18242-4-deepakx.nagaraju@intel.com>

On Wed, Dec 13, 2023 at 03:11:10PM +0800, deepakx.nagaraju@intel.com wrote:
> From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> 
> Move read write functions from altera_tse.h to altera_utils.h
> so it can be shared with future altera ethernet IP's.
> 
> Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



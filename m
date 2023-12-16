Return-Path: <linux-kernel+bounces-2354-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DDF8815B85
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 21:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 607971C220E0
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 20:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AD5328D2;
	Sat, 16 Dec 2023 20:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pzRRsZOk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABA5634549;
	Sat, 16 Dec 2023 20:03:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D533C433C7;
	Sat, 16 Dec 2023 20:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702757016;
	bh=o5tC5YTq/WXKD/3AwBR3tTYlwkgOXyJnI6mB7jjzNTo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pzRRsZOk4t6ICh5erpVJEib6Q5Y6NqXddg2N0lY6cu3cVFeC4wkAghT54v8GrSNPp
	 k2kDdLwzSR6vBtBQksKwAcWAjXducS9kxObQPqWjpuhtJ8BmjTJItbdX+cHB1sbidJ
	 gKgRgVkKnRpzaEyR/34EHNctxqv4zDSsjvd5ktrgjQ6MGLfwARwYvufVj0xvinnvN5
	 5QUc5FjPyLWHm+i9c1t8dfo/4cC18/cGHBv3X+Hs+FNKArlmx36QQOuhpfIIp11PCE
	 zWlfhP1txED3Hfz8wkelU+MPjP1jnUOBbf2hDYmVmG/wnsE8NeRsJPFYYYIZm4TzPC
	 1dlWTZpoxF3yw==
Date: Sat, 16 Dec 2023 20:03:32 +0000
From: Simon Horman <horms@kernel.org>
To: deepakx.nagaraju@intel.com
Cc: joyce.ooi@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	Andy Schevchenko <andriy.schevchenko@linux.intel.com>
Subject: Re: [PATCH 1/5] net: ethernet: altera: remove unneeded assignments
Message-ID: <20231216200332.GT6288@kernel.org>
References: <20231213071112.18242-1-deepakx.nagaraju@intel.com>
 <20231213071112.18242-2-deepakx.nagaraju@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213071112.18242-2-deepakx.nagaraju@intel.com>

On Wed, Dec 13, 2023 at 03:11:08PM +0800, deepakx.nagaraju@intel.com wrote:
> From: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> 
> Remove unneeded assignments in the code.
> 
> Signed-off-by: Nagaraju DeepakX <deepakx.nagaraju@intel.com>
> Reviewed-by: Andy Schevchenko <andriy.schevchenko@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>



Return-Path: <linux-kernel+bounces-16145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38C758239A5
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CEC71C24A9A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3666A29;
	Thu,  4 Jan 2024 00:27:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6D6366;
	Thu,  4 Jan 2024 00:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5ae9b7.dynamic.kabel-deutschland.de [95.90.233.183])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3B49F61E5FE01;
	Thu,  4 Jan 2024 01:24:37 +0100 (CET)
Message-ID: <d8dcef7e-3659-4af4-b391-169081343fba@molgen.mpg.de>
Date: Thu, 4 Jan 2024 01:24:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [RFC PATCH v3 11/11] ABI: pps: Add ABI
 documentation for Intel TIO
Content-Language: en-US
To: lakshmi.sowjanya.d@intel.com
Cc: tglx@linutronix.de, jstultz@google.com, giometti@enneenne.com,
 corbet@lwn.net, linux-kernel@vger.kernel.org, christopher.s.hall@intel.com,
 linux-doc@vger.kernel.org, netdev@vger.kernel.org, pandith.n@intel.com,
 x86@kernel.org, eddie.dong@intel.com, jesse.brandeburg@intel.com,
 linux-sound@vger.kernel.org, alexandre.torgue@foss.st.com,
 mallikarjunappa.sangannavar@intel.com, joabreu@synopsys.com,
 intel-wired-lan@lists.osuosl.org, mcoquelin.stm32@gmail.com,
 thejesh.reddy.t.r@intel.com, perex@perex.cz, anthony.l.nguyen@intel.com,
 andriy.shevchenko@linux.intel.com, davem@davemloft.net
References: <20240103115602.19044-1-lakshmi.sowjanya.d@intel.com>
 <20240103115602.19044-12-lakshmi.sowjanya.d@intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240103115602.19044-12-lakshmi.sowjanya.d@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Lakshmi,


Thank you for your patch.

Am 03.01.24 um 12:56 schrieb lakshmi.sowjanya.d@intel.com:
> From: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> 
> Document sysfs interface for Intel Timed I/O PPS driver

I’d add a dot/period at the end.

> Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> ---
>   Documentation/ABI/testing/sysfs-platform-pps-tio | 7 +++++++
>   1 file changed, 7 insertions(+)
>   create mode 100644 Documentation/ABI/testing/sysfs-platform-pps-tio
> 
> diff --git a/Documentation/ABI/testing/sysfs-platform-pps-tio b/Documentation/ABI/testing/sysfs-platform-pps-tio
> new file mode 100644
> index 000000000000..24a2eb591a05
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-platform-pps-tio
> @@ -0,0 +1,7 @@
> +What:		/sys/devices/platform/INTCxxxx/enable
> +Date:		March 2024
> +KernelVersion	6.9
> +Contact:	Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
> +Description:
> +		(RW) Enable or disable PPS TIO generator output, read to
> +		see the status of hardware(Enabled/Disabled).

Please add a space before the (.

Wouldn’t it be more intuitive, if it returned true/false?


Kind regards,

Paul


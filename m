Return-Path: <linux-kernel+bounces-22899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB62782A51F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79338286283
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 00:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28A4A4C61;
	Thu, 11 Jan 2024 00:00:19 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A2190;
	Thu, 11 Jan 2024 00:00:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 222B1C433C7;
	Thu, 11 Jan 2024 00:00:13 +0000 (UTC)
Message-ID: <7e348eb3-bd34-4c66-9ed6-b5108da80486@linux-m68k.org>
Date: Thu, 11 Jan 2024 10:00:11 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Content-Language: en-US
To: Niklas Cassel <Niklas.Cassel@wdc.com>, Rob Landley <rob@landley.net>
Cc: Petr Vorel <pvorel@suse.cz>, Tim Bird <tim.bird@sony.com>,
 Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven <geert@linux-m68k.org>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>, Li Wang <liwang@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 "automated-testing@lists.yoctoproject.org"
 <automated-testing@lists.yoctoproject.org>,
 "buildroot@buildroot.org" <buildroot@buildroot.org>
References: <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik> <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
 <20240110141455.GC1698252@pevik>
 <40996ea1-3417-1c2f-ddd2-e6ed45cb6f4b@landley.net>
 <ZZ8JbCPd3rq4u7iG@x1-carbon>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <ZZ8JbCPd3rq4u7iG@x1-carbon>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 11/1/24 07:17, Niklas Cassel wrote:
> On Wed, Jan 10, 2024 at 01:23:51PM -0600, Rob Landley wrote:
>> UCLINUX is a long-dead distro. Linaro died in the dot-com crash and its founder
>> Jeff Dionne moved to Japan for his next gig and never came back. On the way out
>> he handed uclinux off to someone else, who didn't do a lot of work maintaining
>> it. Most of the actual support went "upstream" into various packages (linux and
>> busybox and gcc and so on) before the handoff, so you didn't NEED uclinux anymore.
> 
> s/Linaro/Lineo/

Lineo was not founded by Jeff Dionne, see https://en.wikipedia.org/wiki/Lineo
for its genisys. Maybe you are thinking of RT-Control.

Greg


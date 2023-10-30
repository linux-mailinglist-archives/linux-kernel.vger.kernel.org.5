Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5DCE7DB86C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 11:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232432AbjJ3Kro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 06:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231794AbjJ3Krl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 06:47:41 -0400
Received: from frasgout12.his.huawei.com (frasgout12.his.huawei.com [14.137.139.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D39883
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 03:47:34 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.18.147.227])
        by frasgout12.his.huawei.com (SkyGuard) with ESMTP id 4SJqLm2Sclz9xxd8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 18:31:28 +0800 (CST)
Received: from [10.45.155.92] (unknown [10.45.155.92])
        by APP2 (Coremail) with SMTP id GxC2BwDXeraxiT9l7j4pAw--.47299S2;
        Mon, 30 Oct 2023 11:47:22 +0100 (CET)
Message-ID: <2defe3ff-90df-2627-dd19-0442a90b20a4@huaweicloud.com>
Date:   Mon, 30 Oct 2023 11:47:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
Subject: Re: [RFC+Patch] Formal models as source of truth for Software
 Architects.
To:     "Mathew, Cherry G.*" <lkml@bow.st>, linux-kernel@vger.kernel.org
References: <85v8axxrmo.fsf@bow.st>
In-Reply-To: <85v8axxrmo.fsf@bow.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: GxC2BwDXeraxiT9l7j4pAw--.47299S2
X-Coremail-Antispam: 1UD129KBjvAXoWDuw4UZr17tryUZF1DZrW7twb_yoWfJry5Jo
        W3twsxJr4rJrnrA3s2kF1fXrW2g3ykGws7JrZ8WrZxu3WIvF1DC39Ikw4fZa97CF48Kry5
        J3yDXay5JFWDtF4rn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
        AaLaJ3UjIYCTnIWjp_UUU5i7kC6x804xWl14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK
        8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4
        AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26r1j6r1xM28EF7xvwVC0I7IYx2IY6xkF
        7I0E14v26r1j6r4UM28EF7xvwVC2z280aVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv6xkF7I
        0E14v26r4j6r4UJwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
        64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
        8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1Y6r17MIIYrxkI7VAKI48JMIIF0xvE
        2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
        xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URI_DOTEDU autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathew,

I'm not a kernel hacker, but your mail still floated into my inbox 
(probably because you used a combination of "memory" and "model" 
somewhere throughout your text).

The company I currently work at is applying formal methods at various 
places on production code.

A few years ago we also built systems to extract models from C code (for 
TLA+ back then), but those systems are now totally unused (and 
unmaintained) due to poor scalability of exploratory state-based model 
checking.

And then there's the issue that many engineers don't know how to write 
reasonable temporal assertions, especially not ones that can give 
sufficient guarantees to be worth the extra effort and maintenance.

If we use a simplified model of what the system should be doing to 
specify, then usually we are not looking for equivalence but only for 
uni-directional simulation: the spec usually needs to have more degrees 
of freedom than the implementation, which is just a single implementation.

What has worked well for us is anything that works

- directly on the code

- doesn't require learning any kind of math to find bugs with

- is scalable enough to find bugs on real code

- doesn't require a lot of extra effort from the engineers (compared to 
the extra assurance you get)

- doesn't need to be adapted whenever the code changes


I find in software, usually blueprint and skyscraper are in some sense 
the same thing.
Or in some sense, the skyscraper is extracted automatically by a 
compiler/interpreter and installation system - we never actually dig 
anything ourselves, but have the ability to experiment directly on the 
blueprint as we build it.

That's because languages already try to provide us reasonable 
abstraction mechanisms by which we can simplify the code and make it 
more "model-like".

So writing the blueprint twice - once in some modelling language and 
once in a language meant for execution - doesn't really provide a lot of 
benefit.
But it requires doing changes at two levels whenever the software design 
changes. It just violates DRY.

What makes sense in our experience is identifying properties you would 
like the system to have and devising a specific checking mechanism for that.
For example, you might specify the protocol of how the device 
communicates with the system and what assumptions it has (like "don't 
start a second command while the first one hasn't finished"), and then 
check that the driver code obeys this policy.
Then you can change the software code without touching the protocol 
specification, and just re-verify.

In the easiest case, the protocol can be a mock device process that is 
inserted via a form of dependency injection to talk to the real driver 
code during verification, and if the code isn't too complex you can 
exhaustively check several test cases.


Only if the code is highly unreadable for specific reasons like 
performance or talking to legacy ABIs, it can make sense to have an 
"executable comment" that implements the same functional behavior in a 
very concise, readable way (with crud performance/mock APIs replacing 
the actual behavior), and check that the real code and the "executable 
comment" do "the same thing".


The main issues I see when we look at it through the skyscraper analogy 
is that usually people in other engineering disciplines have CAD tools - 
backed by very powerful computers - to really systematically and 
thoroughly check the design.
What we usually have is stress testing and some test suites built by 
hand that miss many cases.


Anyways, that's my (limited) experience.

Hope it helps,

jonas


Am 10/23/2023 um 5:53 PM schrieb Mathew, Cherry G.*:
> Hi Hackers,
>
> I wanted to share with you some work I've been doing for a couple of
> months with the spin verifier and OS C code. [1]
>
> Although not directly and immediately relevant to current kernel
> development, this may be relevant to folks thinking about architecture
> and future directions in managing design complexity.
>
> As I was working on plumbing the ARC code [1] to an actual block driver,
> it dawned on me that there may be additional advantages to writing code
> based on formal models, other than just consistency verification of
> existing production code. So while I'm getting ahead of myself, let me
> re-start in a reasonable middle of this narrative, and describe how I
> got here.
>
> Intro:
> Software must be the only "Engineering" discipline, where the equivalent
> of drawing up an architectural masterplan before you build a skyscraper
> in software, is to start by getting some shovels and start digging the
> basement. While there are a few efforts driven by industry ("inspired"
> by regulation, possibly) [2] [3], I really couldn't find any open source
> attempts at ongoing, continuously integrated work that is in lockstep
> with production sourcecode, with the exception of academic work in
> kernel code verification, eg: [4],  or much smaller codebases such as
> seL4 [5]. (Please feel free to point me at everything I've surely
> missed).
>
> I think we're thinking about the problem from the wrong end. Inspired by
> "Use the Source, Luke", I realised that perhaps we should approach the
> problem of systems software development using the old unix/engineering
> principles of modularity and clean interfaces.
>
> "D3" - Design Driven Development:
> Let's say we want to develop a new block driver interface that "front"s
> an existing block device, say for eg: as a first step to implementing a
> cache of some sort. In addition, let's assume that we've been given the
> requirement that this driver needs to be available on several OSs. As a
> software architect, how do you put something concrete down on paper,
> which serves as the "Source of Truth", before hammering on the actual
> drivers ?
>
> I propose, that a formal model, specified using a modelling language can
> serve this purpose. However, a formal model alone, seems to be
> insufficient. Most formal models seem to exist in a sort of echo chamber
> of their own, where the model sits aside from actual production code,
> or the other extreme, where implementation code itself serves as the
> source of truth, instead of a more abstract formal spec.
>
> While looking for a verifier tool that addresses this problem of the
> "gap" between a model and the implementation code written to express
> that model, I came across the model extractor from the spin
> verifier. [6]. Modex really blew my mind. For the first time, I could
> write a complete loop starting from:
>
> a) A Formal model to represent concurrent processes and the joint
>     evolution of their state.
> b) Invariants expressed in linear temporal logic, to reason about bounds
>     within which this model should operate.
> c) An implementation in a programming language based on eyeballed model
>     code from "a)" above.
> d) A model extractor that could parse the above implementation code, and
>     pull it back into a formal model representation such as in "a)"
>     above.
> e) And finally the ability to apply invariants in "b)" , originally
>     meant for the abstract model in "a)" over the extracted model from
>     "d)".
>
> If there were inconsistencies in step "e)", while none in "b)", this
> could mean that either the extractor hadn't pulled out the right model,
> or the implementation had strayed from that specified in "a)"
> above. This would then require further eyeballing, patching, and
> repeating steps "c)" -> "e)" until the extracted model "d)" and the hand
> crafted model "a)" satisfied the invariants in "b)".
>
> The key assumption here (which I have no way of proving is true) is that
> the satisfaction of invariants in "b)" above, could stand in place for
> equivalence of model and code. Thus we have a development process that
> I'm calling "Design Driven Development" (or "D3" in short form) which
> allows for iterative tightening up of implemented code to a formal
> specification.
>
> Discussion:
> If one were a software architect in a larger project, one could just
> focus on the correctness of one's model, while software engineers could
> focus on implementing the model faithfully, using the D3 loop above to
> ensure fidelity.
>
> I believe this is really powerful - as I'm new to this area, I would
> love to hear from folks that have used this or analogous techniques in
> industry or open-source (ideally both), to get a sense of where my
> current thinking is, with respect to the industry.
>
> Please find attached, a long-ish patch that is heavily WIP. It attempts
> to model a "generic" block driver in spin's promela language. The model
> is in cbd.pm[hl] , the invariants are in cbd.inv. The implementation of
> the model for linux is in linux/cbd.c ( you can use the Makefile to
> compile it as an actual linux module). The implementation of the model
> for NetBSD is in NetBSD/cbd.c (ditto - instructions in respective
> Makefile). Note that I haven't actually tested the driver - it will most
> likely crash, as I haven't really looked at the engineering side of
> things yet - but thought I should publish this right now, to get early
> feedback, and also give a sense of why actual CI testing is still needed
> to ensure that the final implementation plumbing is right.
>
> The "extraction" is specified in a "harness" defined in files with
> extensions "*.prx", suplimented by LUTs to help translate C code back to
> the extracted model. This is where the age of spin/modex becomes evident
> - clearly the extraction language needs to be a lot more expressive (I
> see it analagous to the expressivity in a regex machine, vs. a
> parser). This is an area I'd love to see more work on, to the point
> where we have a tool (if not already available) that can enable
> something like D3 as the gold standard for software quality and
> reliability.
>
> For architects, it takes off the burden of having to rely
> on their memory and random tests and bespoke models to keep state. For
> engineers, it provides a clear "source of truth" and a process based
> mechanism to verify their implementation based on this source. And for
> project managers, there's much better visibility over the entire QA,
> analogous to but much more powerful than a simple TDD style development
> process.
>
> Thank you for your attention - I hope to hear back from you  - do please
> Cc: me if you're replying to list. Especially if you actively work on
> formally verified infrastructure code where QA is a regulatory need
> (avionics ? MISRA-C related constraints ? healthcare ?)
>
> Patch inlined below. To try it out, you need to have 'spin' installed
> using your favourite package manager, and modex [6] compiled , with both
> binaries in $PATH.
>
> Then you can try things out:
>
> 1) Deploy sources to local directory: $ patch -tp1 < cbd.diff
>
> 2) Check out the model. $ make spin-gen; less spinmodel.pml
>
> 3) Try to verify the model (see various commented out #defines in
>     spinmodel.pml if you want to spread your wings.):
>     $ make spin-run
>
> 4) Try to extract the model from linux/cbd.c:
>     $ make clean modex-linux; less spinmodel.pml
>     You can try to verify this extracted spinmodel.pml via 3) above.
>
> 5) Try to extract the model from NetBSD/cbd.c:
>     $ make clean modex-NetBSD; less spinmodel.pml
>     You can try to verify this extracted spinmodel.pml via 3) above.
>
> Looking forward!
>
> Many Thanks,
>
> MattC (/~cherry)
>
> [1]https://mail-index.netbsd.org/tech-kern/2023/09/28/msg029203.html
> [2]https://en.wikipedia.org/wiki/Model-based_systems_engineering
> [3]https://en.wikipedia.org/wiki/Model-driven_engineering
> [4]https://unsat.cs.washington.edu/papers/nelson-hyperkernel.pdf
> [5]https://sel4.systems/
> [6]https://github.com/nimble-code/Modex
>
>
> diff -urN cbd.null/cbd.drv cbd/cbd.drv
> --- cbd.null/cbd.drv	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbd.drv	2023-10-19 17:56:08.023048865 +0000
> @@ -0,0 +1,299 @@
> +/* Spin model driver for NetBSD cbd(4) cbd.c */
> +
> +/*
> + * Copyright 2023, Mathew, Cherry G.<c@bow.st>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * 2. Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include "cbd.pmh"
> +
> +/* We drive the routines concurrently */
> +#define NPROCS 2
> +#define index_pid (_pid - 1)
> +
> +/* Per-device instance state. Currently we only have one instance */
> +bit sc_lock;  /* Driver instance lock */
> +unsigned cbdevsz : DEVSZBITS; /* Same as size of the backing block dev */
> +
> +unsigned cbdev : DEVIDBITS;   	 /* Our Device "handle" */
> +unsigned backingdev : DEVIDBITS;  /* Backing device "handle" */
> +unsigned cachingdev : DEVIDBITS;  /* Caching device "handle" */
> +
> +/* Aggregated traffic stats (per-device) */
> +unsigned cbdbytesread : DEVSZBITS;
> +unsigned cbdbyteswritten : DEVSZBITS;;
> +
> +/*
> + * Helper functions - better as inline because:
> + * - spin parser doesn't care about location vs. preprocessor does.
> + * - trace output looks better
> + */
> +hidden int error[NPROCS];   /* Error indicator for last op */
> +
> +inline SETERROR(_errno)
> +{
> +	error[index_pid] = _errno;
> +}
> +
> +
> +inline
> +mutex_enter(_mutex)
> +{
> +	atomic {
> +		(_mutex == 0) -> _mutex = 1;
> +	}
> +}
> +
> +inline
> +mutex_exit(_mutex)
> +{
> +	atomic {
> +		(_mutex == 1) -> _mutex = 0;
> +	}
> +}
> +
> +/* Set state to "Configured", so that ioctl() can work */
> +inline
> +cbd_init()
> +{
> +	if
> +	:: cbd_unconfigured() ->
> +	   cbdev = CBD_DEVID_CBD1;
> +	:: else -> SETERROR(EBUSY);
> +	   skip;
> +	fi
> +}
> +
> +/* Undo init() */
> +inline
> +cbd_fini()
> +{
> +	do
> +	:: cbd_backed(cbdev) ->
> +	        mutex_enter(sc_lock);
> +		cbd_detach_backend(CBD_DEVID_BACKING);
> +		mutex_exit(sc_lock);
> +	:: cbd_configured(cbdev) ->
> +		mutex_enter(sc_lock);
> +		if
> +		:: cbd_backed(cbdev) -> /* Lost race. Retry */
> +		   mutex_exit(sc_lock);
> +		:: else ->
> +		   cbdev = CBD_DEVID_NONE;
> +		   mutex_exit(sc_lock);
> +		   break;
> +	      	fi
> +	:: else -> skip; /* Retry until things quiesce */
> +	od
> +}
> +
> +inline
> +io_backing(backingdev, bp)
> +{
> +	/* Aggregate i/o data */
> +	if
> +	:: is_set(bp.direction, B_READ) ->
> +	   /* Increment bytes read */
> +	   cbdbytesread = cbdbytesread + bp.spooled;
> +	:: else -> /* Assume B_WRITE */
> +	   /* Increment bytes written */
> +	   cbdbyteswritten = cbdbyteswritten + bp.spooled;
> +	fi
> +
> +}
> +
> +inline
> +ioctl_backing(_dev, _cmd, _data, _flag)
> +{
> +	/* Wouldn't have got here without specific intention.
> +	 * Therefore we just make sure we're in the right state.
> +	 */
> +	SETERROR((cbd_backed(_dev) -> 0 : ENXIO));
> +}
> +
> +inline
> +reset_cbdstate()
> +{
> +	sc_lock = 0;
> +   	cbdbytesread = 0;
> +   	cbdbyteswritten = 0;
> +	cbdev = CBD_DEVID_NONE;
> +	cbdevsz = 0;	
> +	backingdev = CBD_DEVID_NONE;
> +	cachingdev = CBD_DEVID_NONE;	
> +}
> +
> +bit strategy = 0;
> +bit ioctl = 0;
> +bit configured = 0;
> +bit rdwr = 0;
> +
> +inline
> +drive_cbd(_dev, _flags, _buffer,
> +	  _cmd, _data)
> +{
> +	/* Start with state that covers max code */
> +	_dev = CBD_DEVID_CBD1;
> +	set_flag(_flags, FREAD | FWRITE);	
> +
> +	_buffer.error = 0;
> +	_buffer.address = 0;
> +	_buffer.offset = 0;
> +	_buffer.length = CBD_BACKING_DISKSIZE; /* Try moving the whole buffer */
> +	_buffer.spooled = 0;
> +	_buffer.dev = CBD_DEVID_NONE;
> +	set_flag(_buffer.direction, B_READ);
> +
> +	_cmd = CBDIO_ATTACH_BACKEND;
> +	_data = CBD_DEVID_BACKING;
> +
> +	do
> +	::
> +	if
> +	:: (!configured) ->
> +	   cbd_init();
> +	   configured = 1;
> +	:: (ioctl) ->
> +	   cbdioctl(_dev, _cmd, _data, _flags);
> +	   if
> +//#define EXPLORE_IOCTL
> +#ifdef EXPLORE_IOCTL
> +	   :: (_dev > CBD_DEVID_NONE) -> _dev--;
> +	   :: (_dev < CBD_DEVID_CACHING) -> _dev++;
> +#endif	   	   	
> +	   :: (_cmd > CBDIO_INVAL) -> _cmd--;
> +	   :: (_cmd < CBDIO_GET_STATUS) -> _cmd++;
> +	   :: (_data > CBD_DEVID_NONE) -> _data--;
> +	   :: (_data < CBD_DEVID_CACHING) -> _data++;
> +	   :: is_set(_flags, FREAD) -> clear_flag(_flags, FREAD); set_flag(_flags, FWRITE);
> +	   :: is_set(_flags, FWRITE) -> clear_flag(_flags, FWRITE); set_flag(_flags, FREAD);
> +	   :: else -> set_flag(_flags, FREAD);
> +	   fi
> +	   ioctl = 0;
> +
> +	:: (!ioctl) -> ioctl = 1;
> +	:: (strategy) ->
> +	   mutex_enter(sc_lock);	
> +	   cbdstrategy(_buffer);
> +	   mutex_exit(sc_lock);
> +//#define EXPLORE_STRATEGY
> +#ifdef EXPLORE_STRATEGY	
> +	   if
> +	   :: is_set(_buffer.direction, B_WRITE) ->
> +	      	  clear_flag(_buffer.direction, B_WRITE);
> +	      	  set_flag(_buffer.direction, B_READ);
> +	   :: is_set(_buffer.direction, B_READ) ->
> +	      	  clear_flag(_buffer.direction, B_READ);
> +	      	  set_flag(_buffer.direction, B_WRITE);
> +	   :: else ->
> +	   	  set_flag(_buffer.direction, B_READ);
> +	   fi
> +	   strategy = 0;
> +# endif	
> +	:: (!strategy) -> strategy = 1;
> +//#define EXPLORE_BUFFERSTATE
> +#ifdef  EXPLORE_BUFFERSTATE
> +	:: (_buffer.offset < (CBD_BACKING_DISKSIZE + 1)) ->
> +	   	 _buffer.offset++;
> +	:: (_buffer.length < (CBD_BACKING_DISKSIZE + 2)) ->
> +	   	 _buffer.length++;
> +	:: (_buffer.address < VAMAX) -> _buffer.address++;
> +	:: (_buffer.spooled < (CBD_BACKING_DISKSIZE + 2)) ->
> +	   	 _buffer.spooled++;
> +	:: (_buffer.offset > 0) -> _buffer.length--;
> +	:: (_buffer.length > 0) -> _buffer.length--;
> +	:: (_buffer.spooled > 0) -> _buffer.spooled--;
> +	:: (_buffer.address > 0) -> _buffer.address--;
> +#endif
> +//#define EXPLORE_READWRITESTATE
> +#ifdef  EXPLORE_READWRITESTATE
> +	:: (rdwr) ->
> +	   cbdread(_dev, _buffer);
> +	   cbdwrite(_dev, _buffer);
> +	   rdwr = 0;
> +	:: (!rdwr) -> rdwr = 1;
> +	
> +	:: (configured) ->
> +	   cbd_fini();
> +	   configured = 0;
> +#endif	
> +	:: else ->
> +		  break;
> +	fi
> +
> +	od
> +}
> +
> +/* Per proc data to drive the state machine */
> +typedef user_vars_t {
> +	unsigned dev : DEVIDBITS;
> +	unsigned flags : FLAGBITS;
> +	buf_t buffer;
> +	unsigned cmd : IOCMDBITS;
> +
> +	/* IRL, this would be eg: the backing device node path.
> +	 * For now we just pass a fake DEVIDXXX "handle" that
> +	 * represents the backing device.
> +	 */
> +
> +	unsigned data : DEVIDBITS;	
> +};
> +
> +/* Drive functions through various state variations */
> +proctype
> +p_drive_cbd()
> +{
> +	/* Setup initial per-proc caller values. These will get
> +	 * iterated in the inline callees below below
> +	 */
> +	user_vars_t user_vars[NPROCS];
> +	
> +	drive_cbd(user_vars[index_pid].dev, user_vars[index_pid].flags,
> +		  user_vars[index_pid].buffer, user_vars[index_pid].cmd,
> +		  user_vars[index_pid].data);
> +
> +}
> +
> +/* Drive the procs */
> +init {
> +
> +	/* Initialise Device params */
> +	reset_cbdstate();
> +
> +	pid proc;
> +
> +	/* Spin up NPROCS concurrent processes */
> +	atomic {
> +                proc = 0;
> +		do
> +                :: proc < NPROCS ->
> +			   run p_drive_cbd();
> +			   proc++
> +		:: else ->
> +			break
> +		od
> +	}
> +
> +}
> diff -urN cbd.null/cbd.inv cbd/cbd.inv
> --- cbd.null/cbd.inv	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbd.inv	2023-10-18 17:08:10.842776509 +0000
> @@ -0,0 +1,49 @@
> +/* Spin process invariants for NetBSD cbd(4) cbd.c */
> +
> +/*
> + * Copyright 2023, MattC<c@bow.st>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * 2. Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +ltl
> +{
> +/* Checks while outside critical section - ie; kernel state is stable. */
> +	always ((sc_lock == 0) implies (
> +	        /* Device state basic consistency */
> +	        (cbd_configured(cbdev) implies
> +		  !cbd_unconfigured()) &&
> +	        /* Active ioctl passthrough implies configured device */	
> +	        (cbd_backed(cbdev) implies
> +		  cbd_configured(cbdev)) &&
> +		/* There will be I/O eventually */
> +		(eventually always (cbdbytesread + cbdbyteswritten) > 0)
> +		) /* (sc_lock == 0) */
> +	) /* always */ //&&
> +//	always ((sc_lock == 1) implies (
> +	       /* Lock must always be released */
> +//	       (eventually (sc_lock == 0))
> +//	       ) /* (sc_lock == 1) */
> +//	) /* always */ // &&
> +}
> diff -urN cbd.null/cbdioctl.linux.lut cbd/cbdioctl.linux.lut
> --- cbd.null/cbdioctl.linux.lut	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbdioctl.linux.lut	2023-10-23 08:14:11.902411553 +0000
> @@ -0,0 +1,15 @@
> +// cbd_ioctl(...) -> cbdioctl(...)
> +
> +cbd_backed(cbp)		cbd_backed(_dev)
> +
> +Substitute	c_expr { 222 == cmd }	(_cmd == CBDIO_ATTACH_BACKEND)
> +Substitute	c_expr { 333 == cmd }	(_cmd == CBDIO_DETACH_BACKEND)
> +
> +Substitute	c_expr { (cbp==0) }	false
> +Substitute	c_expr { (!cbd_configured(cbp)) }	!cbd_configured(_dev)
> +Substitute	c_expr { (!cbd_backed(cbp)) }	!cbd_backed(_dev)
> +Substitute	c_code { err=(-ENXIO); }	SETERROR(ENXIO)
> +Substitute	c_code { err=(-EBUSY); }	SETERROR(EBUSY)
> +Substitute	c_code { err=(-ENODEV); }	SETERROR(ENODEV)
> +Substitute	c_code { err=(-EPERM); }	SETERROR(EPERM)
> +Substitute	c_code { err=(-ENOTTY); }	skip
> diff -urN cbd.null/cbdioctl.NetBSD.lut cbd/cbdioctl.NetBSD.lut
> --- cbd.null/cbdioctl.NetBSD.lut	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbdioctl.NetBSD.lut	2023-10-23 08:23:23.430620615 +0000
> @@ -0,0 +1,16 @@
> +// cbd_ioctl(...) -> cbdioctl(...)
> +
> +cbd_backed(sc)		cbd_backed(_dev)
> +
> +Substitute	c_expr { (sc==0) }	false
> +Substitute	c_expr { 222 == cmd }	(_cmd == CBDIO_ATTACH_BACKEND)
> +Substitute	c_expr { 333 == cmd }	(_cmd == CBDIO_DETACH_BACKEND)
> +Substitute	c_code { error=EBUSY; }	SETERROR(EBUSY)
> +Substitute	c_code { error=ENODEV; }	SETERROR(ENODEV)
> +Substitute	c_code { error=EPERM; }	SETERROR(EPERM)
> +
> +Substitute	c_code { error=cbd_attach_backend(sc,(&(cbdioctlargs))); }	cbd_attach_backend(_dev, _data)
> +Substitute	c_code { error=cbd_detach_backend(sc); }	cbd_detach_backend(_data)
> +Substitute	c_expr { (!cbd_backed(sc)) }	!cbd_backed(_dev)
> +
> +
> diff -urN cbd.null/cbdattachbackend.linux.lut cbd/cbdattachbackend.linux.lut
> --- cbd.null/cbdattachbackend.linux.lut	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbdattachbackend.linux.lut	2023-10-23 08:12:51.340517105 +0000
> @@ -0,0 +1 @@
> +Substitute	c_expr { IS_ERR(backingdev) }	false
> diff -urN cbd.null/cbdattachbackend.NetBSD.lut cbd/cbdattachbackend.NetBSD.lut
> --- cbd.null/cbdattachbackend.NetBSD.lut	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbdattachbackend.NetBSD.lut	2023-10-23 06:56:21.559519110 +0000
> @@ -0,0 +1,2 @@
> +// Hard hammer - XXX: Find a better way to handle error ?
> +Substitute	c_expr { (error!=0) }	false
> diff -urN cbd.null/cbd.linux.prx cbd/cbd.linux.prx
> --- cbd.null/cbd.linux.prx	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbd.linux.prx	2023-10-23 08:16:16.155489259 +0000
> @@ -0,0 +1,217 @@
> +// Spin model extractor harness for linux/cbd.c written by cherry
> +//
> +%F linux/cbd.c
> +%X -n modexbug // Somehow this is needed to activate per-func LUT
> +%X -L cbdstrategy.linux -n cbd_submit_bio
> +%X -L cbdioctl.linux -n cbd_ioctl
> +%X -L cbdattachbackend.linux -n cbd_attach_backend
> +%X -n cbd_detach_backend
> +%H
> +// Disable effects of all included files and try to implement a subset of the APIs they provide.
> +#define _LINUX_BLKDEV_H
> +
> +// linux/blk_types.h
> +#define SECTOR_SHIFT 9
> +typedef void struct block_device;
> +typedef void blk_mode_t;
> +
> +#define __LINUX_MUTEX_H
> +struct mutex {
> +       void *dummy;
> +};
> +
> +// sys/null.h
> +#define	NULL	0
> +
> +#define true 1
> +#define false 0
> +
> +typedef int bool;
> +
> +/* Linuxisms */
> +#define __user
> +#define __init
> +#define __exit
> +
> +#define module_init(x)
> +#define module_exit(x)
> +#define MODULE_LICENSE(L)
> +
> +%%
> +//%C // c_code {}
> +//%%
> +//%D // c_cdecl {}
> +//%%
> +%L // XXX: Looks like per function tables are broken for now.
> +// Common transformations
> +
> +NonState		hidden	cbd_major	global
> +NonState		hidden	exclusive	global
> +NonState		hidden	cbd_fops	global
> +NonState		hidden	exclusive	global
> +
> +mutex_lock(...		mutex_enter(sc_lock)
> +mutex_unlock(...	mutex_exit(sc_lock)
> +
> +// cbd_submit_bio(...) -> cbdstrategy(...)
> +// See cbdstrategy.linux.lut broad substs which need scope limiting.
> +NonState		hidden	bio	cbd_submit_bio
> +NonState		hidden	cbp	cbd_submit_bio
> +NonState		hidden	bdev	cbd_submit_bio
> +NonState		hidden	bio_offset	cbd_submit_bio
> +NonState		hidden	bdevsz	cbd_submit_bio
> +
> +// Gen-ed Code substitution. This is due to a lack of a sensible parser harness language with the right semantics.
> +Substitute	c_expr { ((bio_offset+bio->bi_iter.bi_size)>bdevsz) }	((bp.offset + bp.length) > cbdevsz)
> +Substitute	c_expr { (bio_op(bio)&REQ_OP_READ) }	is_set(bp.direction, B_READ)
> +Substitute	c_code { bio_offset=((bio_offset>bdevsz) ? bdevsz : bio_offset); }	bp.offset = ((bp.offset > cbdevsz) -> cbdevsz : bp.offset)
> +Substitute	c_code [bio] { bio->bi_iter.bi_size=(bdevsz-bio_offset); }	bp.length = (cbdevsz - bp.offset)
> +Substitute	c_code [bio] { bio->bi_iter.bi_sector=(bio_offset>>9); }	skip
> +Substitute	c_code [bio] { bio->bi_status=BLK_STS_NOTSUPP; }	bp.error = EINVAL;
> +Substitute	c_code [bio] { bio->bi_status=BLK_STS_OFFLINE; }	bp.error = ENXIO
> +
> +// cbd_ioctl(...) -> cbdioctl(...)
> +// See cbdioctl.linux.lut broad substs which need scope limiting.
> +NonState		hidden	userdata	cbd_ioctl
> +NonState		hidden	arg	cbd_ioctl
> +NonState		hidden	cmd	cbd_ioctl
> +NonState		hidden	mode	cbd_ioctl
> +NonState		hidden	bdev	cbd_ioctl
> +NonState		hidden	cbp	cbd_ioctl
> +NonState		hidden	err	cbd_ioctl
> +
> +
> +Substitute	c_expr { (!(mode&BLK_OPEN_WRITE)) }	!is_set(_flag, FWRITE)
> +Substitute	c_code [bdev->bd_disk && bdev] { cbp=bdev->bd_disk->private_data; }	skip
> +Substitute	c_code { err=cbd_attach_backend(cbp,userdata); }	cbd_attach_backend(_dev,_data)
> +Substitute	c_code { err=cbd_detach_backend(cbp); }	cbd_detach_backend(_data)
> +Substitute	c_code [cbp && cbp->backingdev->bd_disk->fops && cbp->backingdev->bd_disk && cbp->backingdev && cbp] { err=cbp->backingdev->bd_disk->fops->ioctl(cbp->backingdev,mode,cmd,arg); }	ioctl_backing(backingdev, _cmd, _data, _flag)
> +
> +// cbd_attach_backend(...) -> cbd_attach_backend()
> +// See cbdattachbackend.linux.lut broad substs which need scope limiting.
> +NonState		hidden	lockedcbp	cbd_attach_backend
> +NonState		hidden	pathname	cbd_attach_backend
> +NonState		hidden	userdata	cbd_attach_backend
> +NonState		hidden	backingdev	cbd_attach_backend
> +
> +Substitute	c_expr { (lockedcbp->cbdev==0) }	(_dev != CBD_DEVID_CBD1)-> SETERROR(ENODEV)
> +Substitute	c_code { pathname=kzalloc(PATH_MAX,GFP_KERNEL); }	skip;
> +Substitute	c_expr { (pathname==0) }	false
> +Substitute	c_expr { (strncpy_from_user(pathname,(void *)userdata,PATH_MAX)==(-EFAULT)) }	(_data != CBD_DEVID_BACKING); SETERROR(EINVAL)
> +Substitute	c_code { kfree(pathname); }	skip
> +Substitute	c_code { backingdev=blkdev_get_by_path(strim(pathname),((BLK_OPEN_READ|BLK_OPEN_WRITE)|BLK_OPEN_EXCL),exclusive,0); }	skip
> +Substitute	c_code [lockedcbp] { lockedcbp->backingdev=backingdev; }	backingdev = CBD_DEVID_BACKING
> +Substitute	c_code [lockedcbp->cbdev && lockedcbp] { set_capacity(lockedcbp->cbdev->bd_disk,bdev_nr_sectors(backingdev)); }	cbdevsz = CBD_BACKING_DISKSIZE
> +
> +// cbd_detach_backend(...) -> cbd_detach_backend()
> +NonState		hidden	lockedcbp	cbd_detach_backend
> +
> +Substitute	c_expr { ((lockedcbp->cbdev==0)||(lockedcbp->backingdev==0)) }	(_dev != CBD_DEVID_CBD1 || backingdev != CBD_DEVID_BACKING) -> SETERROR(ENODEV)
> +Substitute	c_code [lockedcbp] { blkdev_put(lockedcbp->backingdev,exclusive); }	skip
> +Substitute	c_code [lockedcbp] { lockedcbp->backingdev=0; }	backingdev = CBD_DEVID_NONE
> +Substitute	c_code [lockedcbp->cbdev && lockedcbp] { set_capacity(lockedcbp->cbdev->bd_disk,0); }	cbdevsz = 0
> +%%
> +
> +%P
> +hidden int tmpdev; /* Saved during passthrough */
> +
> +inline
> +cbdstrategy(bp)
> +{
> +	#include "_modex_cbd_submit_bio.pml"
> +}
> +
> +inline
> +cbdioctl(_dev, _cmd, _data, _flag)
> +{
> +	SETERROR(0); /* default */
> +	#include "_modex_cbd_ioctl.pml"
> +}
> +
> +inline
> +cbd_attach_backend(_dev, _data)
> +{
> +	SETERROR(0);
> +#include "_modex_cbd_attach_backend.pml"
> +}
> +
> +inline
> +cbd_detach_backend(_dev)
> +{
> +	SETERROR(0);
> +#include "_modex_cbd_detach_backend.pml"
> +}
> +
> +// linux/cbd.c doesn't have read/write fops, so we
> +// fake it to allow cbd.drv to be parsed
> +// However See: cbd.drv: -D EXPLORE_READWRITESTATE
> +/* For now, we just check re-entrancy consistency.
> + * XXX: uio validation
> + */
> +inline
> +cbdread(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(EINVAL);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rd_buf;
> +	rd_buf.direction = B_READ;
> +	rd_buf.error = 0;
> +	rd_buf.length = _uio.length;
> +	rd_buf.address = _uio.address;
> +	rd_buf.spooled = 0;
> +	cbdstrategy(rd_buf);
> +
> +cbdread_out:
> +}
> +
> +inline
> +cbdwrite(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(EINVAL);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);	   	
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rw_buf;
> +	rw_buf.direction = B_WRITE;
> +	rw_buf.error = 0;
> +	rw_buf.length = _uio.length;
> +	rw_buf.address = _uio.address;
> +	rw_buf.spooled = 0;
> +
> +	cbdstrategy(rw_buf);
> +cbdwrite_out:
> +}
> +
> +%%
> \ No newline at end of file
> diff -urN cbd.null/cbd.NetBSD.prx cbd/cbd.NetBSD.prx
> --- cbd.null/cbd.NetBSD.prx	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbd.NetBSD.prx	2023-10-23 08:20:37.150517408 +0000
> @@ -0,0 +1,232 @@
> +// Spin model extractor  harness for NetBSD/cbd.c written by cherry
> +//
> +%F NetBSD/cbd.c
> +%X -n modexbug // Somehow this is needed to activate per-func LUT
> +%X -L cbdstrategy.NetBSD -n cbd_strategy
> +%X -L cbdioctl.NetBSD -n cbd_ioctl
> +%X -L cbdattachbackend.NetBSD -n cbd_attach_backend
> +%X -n cbd_detach_backend
> +%H
> +// Disable effects of all included files and try to implement a subset of the APIs they provide.
> +
> +#define _SYS_TYPES_H_
> +#define _SYS_STAT_H_
> +#define _SYS_BUF_H
> +#define _SYS_BUFQ_H
> +#define _SYS_CONF_H
> +#define _SYS_DISK_H
> +#define _SYS_DISKLABEL_H
> +#define _SYS_ERRNO_H
> +#define _UVM_PROT_
> +#define _SYS_ACL_H
> +#define _SYS_VNODE_IF_H_
> +#define _SYS_VNODE_H_
> +
> +typedef void device_t;
> +//typedef void *kmutex_t; //Kludgy hack, see below
> +#define kmutex_t (void *)
> +typedef void dev_t;
> +typedef void u_long;
> +typedef void buf_t;
> +typedef void uint64_t;
> +
> +/* Override switch arrays */
> +void cbd_bdevsw;
> +void cbd_cdevsw;
> +void cbddkdriver;
> +
> +#define CFATTACH_DECL3_NEW(_ign1, _ign2, _ign3, _ign4, _ign5, _ign6, _ign7, _ign8, _ign9)
> +
> +// sys/null.h
> +#define	NULL	0
> +
> +#define true 1
> +#define false 0
> +
> +typedef int bool;
> +
> +#define disk_busy(_dk)
> +#define disk_unbusy(_dk, _count, _flags)
> +
> +#define biodone(_bp)
> +
> +%%
> +//%C // c_code {}
> +//%%
> +//%D // c_cdecl {}
> +//%%
> +%L // XXX: Looks like per function tables are broken for now.
> +// Common transformations
> +
> +NonState		hidden	cbd_major	global
> +NonState		hidden	cbd_cdevsw	global
> +NonState		hidden	sc_lock		global
> +
> +mutex_enter(...		mutex_enter(sc_lock)
> +mutex_exit(...		mutex_exit(sc_lock)
> +
> +Substitute	c_code { unit=DISKUNIT(dev); }	skip
> +Substitute	c_code { sc=device_lookup_private((&(cbd_cd)),unit); }	skip
> +
> +// cbd_strategy(...) -> cbdstrategy(...)
> +NonState		hidden	sc		cbd_strategy
> +NonState		hidden	buf		cbd_strategy
> +NonState		hidden	dev		cbd_strategy
> +NonState		hidden	unit		cbd_strategy
> +
> +// Gen-ed Code substitution. This is due to a lack of a sensible parser harness language with the right semantics.
> +Substitute	c_expr { ((dbtob(buf->b_blkno)+buf->b_bcount)>sc->sc_tvn_bsize) }	((bp.offset + bp.length) > cbdevsz)
> +Substitute	c_expr { BUF_ISREAD(buf) }	is_set(bp.direction, B_READ)
> +Substitute	c_code [sc && sc && buf && buf] { buf->b_blkno=((dbtob(buf->b_blkno)>sc->sc_tvn_bsize) ? F: btodb(sc->sc_tvn_bsize) : bufb_blkno); }	bp.offset = ((bp.offset > cbdevsz) -> cbdevsz : bp.offset)
> +Substitute	c_code [buf && sc && buf] { buf->b_bcount=(sc->sc_tvn_bsize-dbtob(buf->b_blkno)); }	bp.length = (cbdevsz - bp.offset)
> +Substitute	c_code [buf] { buf->b_error=EINVAL; }	bp.error = EINVAL
> +Substitute	c_code [buf] { buf->b_error=ENXIO; }	bp.error = ENXIO
> +
> +// cbd_ioctl(...) -> cbdioctl(...)
> +NonState		hidden	sc		cbd_ioctl
> +NonState		hidden	dev		cbd_ioctl
> +NonState		hidden	cmd		cbd_ioctl
> +NonState		hidden	data		cbd_ioctl
> +NonState		hidden	flag		cbd_ioctl
> +NonState		hidden	l		cbd_ioctl
> +NonState		hidden	unit		cbd_ioctl
> +NonState		hidden	error		cbd_ioctl
> +NonState		hidden	cbdioctlargs		cbd_ioctl
> +
> +Substitute	c_code { cbdioctlargs.diskpath=data; }	skip
> +Substitute	c_code { cbdioctlargs.l=l; }	skip
> +Substitute	c_expr { (!cbd_configured(sc)) }	!cbd_configured(_dev) -> SETERROR(ENXIO)
> +Substitute	c_expr { (!(flag&FWRITE)) }	!is_set(_flag, FWRITE)
> +Substitute	c_code [l && sc] { error=VOP_IOCTL(sc->sc_tvn,cmd,data,flag,l->l_cred); }	ioctl_backing(backingdev, _cmd, _data, _flag)
> +
> +// cbd_attach_backend(...) -> cbd_attach_backend()
> +NonState		hidden	lockedsc	cbd_attach_backend
> +NonState		hidden	cbdioctl	cbd_attach_backend
> +NonState		hidden	data	cbd_attach_backend
> +NonState		hidden	pbuf	cbd_attach_backend
> +NonState		hidden	error	cbd_attach_backend
> +NonState		hidden	vp	cbd_attach_backend
> +NonState		hidden	numsec	cbd_attach_backend
> +NonState		hidden	secsz	cbd_attach_backend
> +
> +Substitute	c_expr { (lockedsc->sc_dev==0) }	(_dev != CBD_DEVID_CBD1)-> SETERROR(ENODEV)
> +Substitute	c_code [cbdioctl] { error=pathbuf_copyin(cbdioctl->diskpath,(&(pbuf))); }	skip
> +Substitute	c_code [cbdioctl] { error=vn_bdev_openpath(pbuf,(&(vp)),cbdioctl->l); }	if :: (_data != CBD_DEVID_BACKING) -> SETERROR(ENODEV) :: else; fi
> +Substitute	c_code { pathbuf_destroy(pbuf); }	skip
> +Substitute	c_code { error=getdisksize(vp,(&(numsec)),(&(secsz))); }	skip
> +Substitute	c_code [lockedsc] { lockedsc->sc_tvn=vp; }	backingdev = CBD_DEVID_BACKING
> +Substitute	c_code [lockedsc] { lockedsc->sc_tvn_bsize=(numsec*secsz); }	cbdevsz = CBD_BACKING_DISKSIZE
> +Substitute	c_code [cbdioctl->l && cbdioctl && lockedsc] { lockedsc->sc_tvn_l_cred=cbdioctl->l->l_cred; }	skip
> +
> +
> +// cbd_detach_backend(...) -> cbd_detach_backend()
> +NonState		hidden	lockedsc	cbd_detach_backend
> +
> +Substitute	c_expr { ((((lockedsc->sc_dev==0)||(lockedsc->sc_tvn==0))||(lockedsc->sc_tvn_bsize==0))||(lockedsc->sc_tvn_l_cred==0)) }	(_dev != CBD_DEVID_CBD1 || backingdev != CBD_DEVID_BACKING) -> SETERROR(ENODEV);
> +Substitute	c_code [lockedsc && lockedsc] { vn_close(lockedsc->sc_tvn,(FREAD|FWRITE),lockedsc->sc_tvn_l_cred); }	skip
> +Substitute	c_code [lockedsc] { lockedsc->sc_tvn_bsize=0; }	cbdevsz = 0
> +Substitute	c_code [lockedsc] { lockedsc->sc_tvn_l_cred=0; }	skip
> +Substitute	c_code [lockedsc] { lockedsc->sc_tvn=0; }	backingdev = CBD_DEVID_NONE
> +%%
> +
> +%P
> +hidden int tmpdev; /* Saved during passthrough */
> +
> +inline
> +cbdstrategy(bp)
> +{
> +	#include "_modex_cbd_strategy.pml"
> +}
> +
> +inline
> +cbdioctl(_dev, _cmd, _data, _flag)
> +{
> +	SETERROR(0); /* default */
> +	#include "_modex_cbd_ioctl.pml"
> +}
> +
> +inline
> +cbd_attach_backend(_dev, _data)
> +{
> +	SETERROR(0);
> +#include "_modex_cbd_attach_backend.pml"
> +}
> +
> +inline
> +cbd_detach_backend(_dev)
> +{
> +	SETERROR(0);
> +#include "_modex_cbd_detach_backend.pml"
> +}
> +
> +// XXX: please extract below functions.
> +/* For now, we just check re-entrancy consistency.
> + * XXX: uio validation
> + */
> +inline
> +cbdread(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(EINVAL);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rd_buf;
> +	rd_buf.direction = B_READ;
> +	rd_buf.error = 0;
> +	rd_buf.length = _uio.length;
> +	rd_buf.address = _uio.address;
> +	rd_buf.spooled = 0;
> +	cbdstrategy(rd_buf);
> +
> +cbdread_out:
> +}
> +
> +inline
> +cbdwrite(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(EINVAL);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);	   	
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rw_buf;
> +	rw_buf.direction = B_WRITE;
> +	rw_buf.error = 0;
> +	rw_buf.length = _uio.length;
> +	rw_buf.address = _uio.address;
> +	rw_buf.spooled = 0;
> +
> +	cbdstrategy(rw_buf);
> +cbdwrite_out:
> +}
> +
> +%%
> \ No newline at end of file
> diff -urN cbd.null/cbd.pmh cbd/cbd.pmh
> --- cbd.null/cbd.pmh	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbd.pmh	2023-10-22 19:48:38.564639937 +0000
> @@ -0,0 +1,120 @@
> +/*
> + * Copyright 2023, MattC<c@bow.st>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * 2. Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#ifndef _CBD_PMH_
> +#define _CBD_PMH_
> +
> +#define ERRBITS 6 /* Add as list below grows */
> +
> +/* Modelled on NetBSD sys/errno.h */
> +#define	EPERM		1		/* Operation not permitted */
> +#define	ENOENT		2		/* No such file or directory */
> +#define	EIO		5		/* Input/output error */
> +#define	ENXIO		6		/* Device not configured */
> +#define	EBADF		9		/* Bad file descriptor */
> +#define	EBUSY		16		/* Device busy */
> +#define	ENODEV		19		/* Operation not supported by device */
> +#define	EINVAL		22		/* Invalid argument */
> +
> +#define DEVSZBITS 10 /* Max block device log2(sz) */
> +#define DEVIDBITS 4 /* Add more as list below grows */
> +
> +/* handle IDs for "device"s */
> +#define CBD_DEVID_NONE 0
> +#define CBD_DEVID_CBD1 1
> +#define CBD_DEVID_BACKING 2
> +#define CBD_DEVID_CACHING 3
> +
> +/* "State" values, to report current states, on query */
> +#define CBD_UNCONFIGURED 0
> +#define CBD_CONFIGURED 1
> +#define CBD_BACKED 2
> +#define CBD_CACHED 3
> +
> +#define FLAGBITS 4
> +/* Buffer direction flag (mutually exclusive) */
> +#define	B_READ		1	/* Read flag. */
> +#define	B_WRITE		2	/* Write flag. */
> +
> +/* dev read()/write(). Write flag imples Read flag */
> +#define FREAD 1
> +#define FWRITE 3
> +
> +inline set_flag(_flags, _FLAG) { _flags = (_flags | _FLAG) }
> +inline clear_flag(_flags, _FLAG) { _flags = _flags & ~_FLAG }
> +#define is_set(_flags, _FLAG) ((_flags & _FLAG) && 1)
> +
> +#define IOCMDBITS 4
> +
> +/* ioctl related command codes */
> +#define CBDIO_INVAL 0
> +#define CBDIO_ATTACH_BACKEND 1
> +#define CBDIO_DETACH_BACKEND 2
> +#define CBDIO_GET_STATUS 3
> +
> +#define VABITS DEVSZBITS
> +#define VAMAX (1 << (VABITS - 1)) /* A boundary for a "valid" address */
> +#define is_valid_address(_addr) (_addr <= VAMAX)
> +
> +#define CBD_BACKING_DISKSIZE (VAMAX)
> +
> +/* Device state queries */
> +#define cbd_unconfigured() (cbdev == CBD_DEVID_NONE)
> +
> +/* In a multi-device scenario (out of scope of this
> + * model), this would be a search for the device matching
> + * the arg _dev.
> + */
> +
> +#define cbd_configured(_dev) ((cbdev == CBD_DEVID_CBD1) && (_dev == cbdev))
> +
> +#define cbd_backed(_dev) (cbd_configured(_dev) && (backingdev == CBD_DEVID_BACKING))
> +
> +#define cbd_cached(_dev) (cbd_backed() && cachingdev == CBD_DEVID_CACHING)
> +
> +#define cbd_status(_dev) \
> +	((_dev == CBD_DEVID_NONE) -> CBD_UNCONFIGURED : \
> +	     ((cbdev == CBD_DEVID_CBD1) -> \
> +	      ((backingdev == CBD_DEVID_BACKING) -> \
> +	       ((cachingdev == CBD_DEVID_CACHING) -> \
> +	      		  CBD_CACHED : CBD_BACKED) : \
> +			  CBD_CONFIGURED) : \
> +			  CBD_UNCONFIGURED))
> +
> +
> +typedef buf_t {
> +	unsigned error : ERRBITS;		/* error flagged during processing */
> +	unsigned address : VABITS;		/* address representation */
> +	unsigned offset	 : DEVSZBITS;		/* Offset into device */
> +	unsigned length : DEVSZBITS;		/* total length of buffer */
> +	unsigned spooled : DEVSZBITS;		/* length processed so far */	
> +	unsigned direction : FLAGBITS;		/* whether callee is to read from or write to */
> +	unsigned dev : DEVIDBITS;		/* Device involved */
> +};
> +
> +
> +#endif  /* _CBD_PMH_ */
> \ No newline at end of file
> diff -urN cbd.null/cbd.pml cbd/cbd.pml
> --- cbd.null/cbd.pml	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbd.pml	2023-10-22 21:00:12.814145286 +0000
> @@ -0,0 +1,261 @@
> +/* Spin process models for NetBSD cbd(4) cbd.c */
> +
> +/*
> + * Copyright 2023, MattC<c@bow.st>
> + *
> + * Redistribution and use in source and binary forms, with or without
> + * modification, are permitted provided that the following conditions
> + * are met:
> + *
> + * 1. Redistributions of source code must retain the above copyright
> + * notice, this list of conditions and the following disclaimer.
> + *
> + * 2. Redistributions in binary form must reproduce the above copyright
> + * notice, this list of conditions and the following disclaimer in the
> + * documentation and/or other materials provided with the distribution.
> + *
> + * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
> + * “AS IS” AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
> + * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
> + * A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
> + * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
> + * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
> + * LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
> + * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
> + * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
> + * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
> + * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
> + */
> +
> +#include "cbd.pmh"
> +
> +hidden	int tmpdev; /* Saved during passthrough */
> +inline
> +cbdstrategy(/* buf_t */ bp)
> +{
> +
> +
> +	/* sanity check buffer */
> +
> +	if
> +	:: ((bp.offset + bp.length) > cbdevsz) ->
> +	   if
> +	   :: is_set(bp.direction, B_READ) ->
> +	      /* Clip the requested length.
> +	       * Total length effectively read will be in
> +	       * bp.spooled
> +	       */
> +	      bp.offset = ((bp.offset > cbdevsz) -> cbdevsz :
> +	      		  	      bp.offset);
> +	      bp.length = (cbdevsz - bp.offset);
> +				
> +	      skip;
> +
> +	   :: is_set(bp.direction, B_WRITE) ->
> +	      bp.error = EINVAL;
> +	   fi
> +	   goto strategy_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	
> +	if /* Always check if device is still active before acting */
> +	:: cbd_backed(bp.dev) ->
> +	   tmpdev = bp.dev;
> +	   mutex_enter(sc_lock);		
> +	   bp.dev = backingdev; /* Set for callee */
> +	   io_backing(backingdev, bp);
> +	   bp.dev = tmpdev; /* Reset for caller */
> +	   mutex_exit(sc_lock);	
> +	:: else -> /* Fallback - don't block */
> +		   bp.error = ENXIO;
> +		   goto strategy_out;
> +	fi
> +strategy_out:
> +
> +}
> +
> +/* Attach backing disk device specified in data */
> +
> +inline
> +cbd_attach_backend(_dev, _data)
> +{
> +	SETERROR(0);
> +
> +	/* Simulate data validation */	
> +	if
> +	:: (_dev != CBD_DEVID_CBD1 || /* Device validity */
> +	    _data != CBD_DEVID_BACKING) ->
> +	      SETERROR(ENODEV);
> +	      goto attach_out;
> +	:: else ->
> +	      /* IRL, this would come from the backing dev */
> +	      cbdevsz = CBD_BACKING_DISKSIZE;
> +	      backingdev = _data;
> +	fi
> +
> +attach_out:
> +}
> +
> +/* Detach backing disk device specified in data */
> +inline
> +cbd_detach_backend(_dev)
> +{
> +	SETERROR(0);
> +
> +	/* Simulate dev state validation */	
> +
> +	if
> +	:: (_dev != CBD_DEVID_CBD1 ||
> +	    backingdev != CBD_DEVID_BACKING) ->
> +	      SETERROR(ENODEV);
> +	      goto detach_out;
> +	:: else ->
> +	      backingdev = CBD_DEVID_NONE;
> +	      cbdevsz = 0;
> +	fi
> +
> +detach_out:
> +}
> +
> +inline
> +cbdioctl(_dev, _cmd, _data, _flag)
> +{
> +	SETERROR(0); /* default */
> +
> +	mutex_enter(sc_lock);	
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(ENXIO);
> +	   goto ioctl_out; /* Invalid device ID */
> +	:: else ->
> +	   skip;
> +	fi
> +
> +	if
> +	:: (_cmd == CBDIO_ATTACH_BACKEND) ->
> +	   /* Simulate attaching a backing device */
> +	   if
> +	   :: cbd_backed(_dev) -> /* Already backed. */
> +	      SETERROR(EBUSY); /* return EBUSY */
> +	      goto ioctl_out;
> +	   :: else ->
> +	      skip;
> +	   fi
> +	   if
> +	   :: !is_set(_flag, FWRITE) -> /* Semantic inconsistency */
> +	      SETERROR(EPERM);
> +	      goto ioctl_out;
> +	   :: else ->
> +	      skip;
> +	   fi
> +	   cbd_attach_backend(_dev, _data);
> +	   goto ioctl_out;
> +
> +	 :: (_cmd == CBDIO_DETACH_BACKEND) ->
> +	   /* Simulate detaching a backing device */
> +	   if
> +	   :: !cbd_backed(_dev) -> /* Nothing to detach. */
> +	      SETERROR(ENODEV);
> +	      goto ioctl_out;
> +	   :: else ->
> +	      skip;
> +	   fi
> +	   if
> +	   :: !is_set(_flag, FWRITE) -> /* Semantic inconsistency */
> +	      SETERROR(EPERM);
> +	      goto ioctl_out;
> +	   :: else ->
> +	      skip;
> +	   fi
> +	   cbd_detach_backend(_dev);
> +	   goto ioctl_out;
> +
> +	:: (_cmd == CBDIO_GET_STATUS) ->
> +	   /* Simulate Query */
> +	   /* dev "handle" as proxy for "status" */
> +	   _data = cbd_status(_dev);
> +	   goto ioctl_out; /* NOP */
> +	:: (_cmd == CBDIO_INVAL) -> /* Adversarial/careless user */
> +	   SETERROR(EINVAL);
> +	   goto ioctl_out;
> +	:: else ->
> +	   skip; /* Pass through to backing device ioctl() */
> +	fi
> +
> +	/* Anything else is passed to the backing disk */
> +	ioctl_backing(backingdev, _cmd, _data, _flag);
> +
> +ioctl_out:
> +	mutex_exit(sc_lock);
> +}
> +
> +/* For now, we just check re-entrancy consistency.
> + * XXX: uio validation
> + */
> +inline
> +cbdread(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(ENXIO);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rd_buf;
> +	rd_buf.direction = B_READ;
> +	rd_buf.error = 0;
> +	rd_buf.length = _uio.length;
> +	rd_buf.address = _uio.address;
> +	rd_buf.spooled = 0;
> +	cbdstrategy(rd_buf);
> +
> +cbdread_out:
> +}
> +
> +inline
> +cbdwrite(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(ENXIO);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);	   	
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rw_buf;
> +	rw_buf.direction = B_WRITE;
> +	rw_buf.error = 0;
> +	rw_buf.length = _uio.length;
> +	rw_buf.address = _uio.address;
> +	rw_buf.spooled = 0;
> +
> +	cbdstrategy(rw_buf);
> +cbdwrite_out:
> +}
> +
> diff -urN cbd.null/cbd.prx cbd/cbd.prx
> --- cbd.null/cbd.prx	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbd.prx	2023-10-19 20:12:35.838587981 +0000
> @@ -0,0 +1,218 @@
> +// Spin model extractor harness written by cherry
> +//
> +%F linux/cbd.c
> +%X -n modexbug // Somehow this is needed to activate per-func LUT
> +
> +// See cbdstrategy for translation table only for *function()*s
> +%X -L cbdstrategy -n cbd_submit_bio
> +// See cbdioctl.lut for translation table only for *function()*s
> +%X -L cbdioctl -n cbd_ioctl
> +
> +%X -n cbd_attach_backend
> +%X -n cbd_detach_backend
> +%H
> +// Disable effects of all included files and try to implement a subset of the APIs they provide.
> +#define _LINUX_BLKDEV_H
> +
> +// linux/blk_types.h
> +#define SECTOR_SHIFT 9
> +typedef void struct block_device;
> +typedef void blk_mode_t;
> +
> +#define __LINUX_MUTEX_H
> +struct mutex {
> +       void *dummy;
> +};
> +
> +// sys/null.h
> +#define	NULL	0
> +
> +#define true 1
> +#define false 0
> +
> +typedef int bool;
> +
> +/* Linuxisms */
> +#define __user
> +#define __init
> +#define __exit
> +
> +#define module_init(x)
> +#define module_exit(x)
> +#define MODULE_LICENSE(L)
> +
> +%%
> +//%C // c_code {}
> +//%%
> +//%D // c_cdecl {}
> +//%%
> +%L // XXX: Looks like per function tables are broken for now.
> +// Common transformations
> +
> +NonState		hidden	cbd_major	global
> +NonState		hidden	exclusive	global
> +NonState		hidden	cbd_fops	global
> +NonState		hidden	exclusive	global
> +
> +mutex_lock(...		mutex_enter(sc_lock)
> +mutex_unlock(...	mutex_exit(sc_lock)
> +
> +// cbd_submit_bio(...) -> cbdstrategy(...)
> +NonState		hidden	bio	cbd_submit_bio
> +NonState		hidden	cbp	cbd_submit_bio
> +NonState		hidden	bdev	cbd_submit_bio
> +NonState		hidden	bio_offset	cbd_submit_bio
> +NonState		hidden	bdevsz	cbd_submit_bio
> +
> +// Gen-ed Code substitution. This is due to a lack of a sensible parser harness language with the right semantics.
> +Substitute	c_expr { ((bio_offset+bio->bi_iter.bi_size)>bdevsz) }	((bp.offset + bp.length) > cbdevsz)
> +Substitute	c_expr { (bio_op(bio)&REQ_OP_READ) }	is_set(bp.direction, B_READ)
> +Substitute	c_code { bio_offset=((bio_offset>bdevsz) ? bdevsz : bio_offset); }	bp.offset = ((bp.offset > cbdevsz) -> cbdevsz : bp.offset)
> +Substitute	c_code [bio] { bio->bi_iter.bi_size=(bdevsz-bio_offset); }	bp.length = (cbdevsz - bp.offset)
> +Substitute	c_code [bio] { bio->bi_iter.bi_sector=(bio_offset>>9); }	skip
> +Substitute	c_code [bio] { bio->bi_status=BLK_STS_IOERR; }	bp.error = EIO;
> +Substitute	c_code [bio] { bio->bi_status=BLK_STS_OFFLINE; }	bp.error = ENXIO
> +
> +// cbd_ioctl(...) -> cbdioctl(...)
> +NonState		hidden	userdata	cbd_ioctl
> +NonState		hidden	arg	cbd_ioctl
> +NonState		hidden	cmd	cbd_ioctl
> +NonState		hidden	mode	cbd_ioctl
> +NonState		hidden	bdev	cbd_ioctl
> +NonState		hidden	cbp	cbd_ioctl
> +NonState		hidden	err	cbd_ioctl
> +
> +
> +Substitute	c_expr { (!cbd_configured(cbp)) }	cbd_configured(_dev)
> +Substitute	c_code { err=(-ENXIO); }	SETERROR(ENXIO)
> +Substitute	c_expr { 222 == cmd }	(_cmd == CBDIO_ATTACH_BACKEND)
> +Substitute	c_expr { 333 == cmd }	(_cmd == CBDIO_DETACH_BACKEND)
> +Substitute	c_code [bdev->bd_disk && bdev] { cbp=bdev->bd_disk->private_data; }	skip
> +Substitute	c_code { err=cbd_attach_backend(cbp,userdata); }	cbd_attach_backend(_data)
> +Substitute	c_code { err=cbd_detach_backend(cbp); }	cbd_detach_backend(_data)
> +Substitute	c_code [cbp && cbp->backingdev->bd_disk->fops && cbp->backingdev->bd_disk && cbp->backingdev && cbp] { err=cbp->backingdev->bd_disk->fops->ioctl(cbp->backingdev,mode,cmd,arg); }	ioctl_backing(backingdev, _cmd, _data, _flag)
> +Substitute	c_code { err=(-ENOTTY); }	skip
> +
> +// cbd_attach_backend(...) -> cbd_attach_backend()
> +NonState		hidden	lockedcbp	cbd_attach_backend
> +NonState		hidden	pathname	cbd_attach_backend
> +NonState		hidden	userdata	cbd_attach_backend
> +NonState		hidden	backingdev	cbd_attach_backend
> +
> +Substitute	c_code { pathname=kzalloc(PATH_MAX,GFP_KERNEL); }	skip;
> +Substitute	c_expr { (pathname==0) }	false
> +Substitute	c_expr { (strncpy_from_user(pathname,(void *)userdata,PATH_MAX)==(-EFAULT)) }	(_data != CBD_DEVID_BACKING); SETERROR(EINVAL)
> +Substitute	c_code { kfree(pathname); }	skip
> +Substitute	c_code { backingdev=blkdev_get_by_path(strim(pathname),((BLK_OPEN_READ|BLK_OPEN_WRITE)|BLK_OPEN_EXCL),exclusive,0); }	skip
> +Substitute	c_expr { IS_ERR(backingdev) }	false
> +Substitute	c_code [lockedcbp] { lockedcbp->backingdev=backingdev; }	backingdev = CBD_DEVID_BACKING
> +Substitute	c_code [lockedcbp->cbdev && lockedcbp] { set_capacity(lockedcbp->cbdev->bd_disk,bdev_nr_sectors(backingdev)); }	cbdevsz = CBD_BACKING_DISKSIZE
> +
> +NonState		hidden	lockedcbp	cbd_detach_backend
> +Substitute	c_code [lockedcbp] { blkdev_put(lockedcbp->backingdev,exclusive); }	skip
> +Substitute	c_code [lockedcbp] { lockedcbp->backingdev=0; }	backingdev = CBD_DEVID_NONE
> +Substitute	c_code [lockedcbp->cbdev && lockedcbp] { set_capacity(lockedcbp->cbdev->bd_disk,0); }	cbdevsz = 0
> +%%
> +
> +%P
> +hidden int tmpdev; /* Saved during passthrough */
> +
> +inline
> +cbdstrategy(bp)
> +{
> +#include "_modex_cbd_submit_bio.pml"
> +}
> +
> +inline
> +cbdioctl(_dev, _cmd, _data, _flag)
> +{
> +#include "_modex_cbd_ioctl.pml"
> +}
> +
> +inline
> +cbd_attach_backend(_data)
> +{
> +	SETERROR(0);
> +#include "_modex_cbd_attach_backend.pml"
> +}
> +
> +inline
> +cbd_detach_backend(_data)
> +{
> +	SETERROR(0);
> +#include "_modex_cbd_detach_backend.pml"
> +}
> +
> +// linux/cbd.c doesn't have read/write fops, so we
> +// fake it to allow cbd.drv to be parsed
> +// However See: cbd.drv: -D EXPLORE_READWRITESTATE
> +/* For now, we just check re-entrancy consistency.
> + * XXX: uio validation
> + */
> +inline
> +cbdread(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(EINVAL);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdread_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rd_buf;
> +	rd_buf.direction = B_READ;
> +	rd_buf.error = 0;
> +	rd_buf.length = _uio.length;
> +	rd_buf.address = _uio.address;
> +	rd_buf.spooled = 0;
> +	cbdstrategy(rd_buf);
> +
> +cbdread_out:
> +}
> +
> +inline
> +cbdwrite(_dev, _uio)
> +{
> +	SETERROR(0);
> +
> +	/* Check for backing disk */
> +	mutex_enter(sc_lock);
> +	if
> +	:: !cbd_configured(_dev) ->
> +	   SETERROR(EINVAL);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: !cbd_backed(_dev) ->
> +	   SETERROR(ENOENT);
> +	   mutex_exit(sc_lock);	
> +	   goto cbdwrite_out;
> +	:: else ->
> +	   skip;
> +	fi
> +	mutex_exit(sc_lock);	   	
> +
> +	/* simulate uio -> buf translation */
> +	buf_t rw_buf;
> +	rw_buf.direction = B_WRITE;
> +	rw_buf.error = 0;
> +	rw_buf.length = _uio.length;
> +	rw_buf.address = _uio.address;
> +	rw_buf.spooled = 0;
> +
> +	cbdstrategy(rw_buf);
> +cbdwrite_out:
> +}
> +
> +%%
> \ No newline at end of file
> diff -urN cbd.null/cbdstrategy.linux.lut cbd/cbdstrategy.linux.lut
> --- cbd.null/cbdstrategy.linux.lut	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbdstrategy.linux.lut	2023-10-19 13:12:04.576568138 +0000
> @@ -0,0 +1,7 @@
> +// cbd_submit_bio(...) -> cbdstrategy(...)
> +
> +cbd_backed(cbp)		cbd_backed(bp.dev)
> +bio_set_dev(...		tmpdev = bp.dev; bp.dev = backingdev
> +submit_bio_noacct(bio)	io_backing(backingdev, bp); bp.dev = tmpdev
> +
> +
> diff -urN cbd.null/cbdstrategy.NetBSD.lut cbd/cbdstrategy.NetBSD.lut
> --- cbd.null/cbdstrategy.NetBSD.lut	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/cbdstrategy.NetBSD.lut	2023-10-23 08:23:18.598269036 +0000
> @@ -0,0 +1,10 @@
> +// cbd_strategy(...) -> cbdstrategy(...)
> +
> +cbd_backed(sc)		cbd_backed(bp.dev)
> +VOP_STRATEGY(sc->sc_tvn,buf)	tmpdev = bp.dev; bp.dev = backingdev; io_backing(backingdev, bp); bp.dev = tmpdev
> +
> +Substitute	c_expr { (sc==0) }	false
> +
> +
> +
> +
> diff -urN cbd.null/linux/cbd.c cbd/linux/cbd.c
> --- cbd.null/linux/cbd.c	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/linux/cbd.c	2023-10-22 21:10:18.387421555 +0000
> @@ -0,0 +1,315 @@
> +#include <linux/mutex.h>
> +#include <linux/blkdev.h>
> +
> +#define CBD_ATTACH_BACKEND 222 /* XXX: fit into ioctl namespace */
> +#define CBD_DETACH_BACKEND 333 /* XXX: ditto */
> +
> +
> +/* Driver-wide values that don't change over the life of the module */
> +
> +/* At the moment, we assume that there's 1:1 correspondence between  a
> + * driver instance (ie; module_init/exit pair) and a device
> + * instance. Thus we use cbd_major below as the primary "key" to
> + * lookup device state, via blk_get_no_open(). Note - this is not
> + * related to "minor" devices, which can still use cbd_major as
> + * above.
> + * XXX: Fix this.
> + */
> +static int cbd_major = 0;
> +static char *exclusive = "cbd_ioctl";
> +
> +struct cbd_private {
> +	struct block_device *cbdev;	/* Back ref for state tracking
> +					 * - see cbd_configured()
> +					 * below
> +					 */
> +	struct block_device *backingdev;
> +	struct mutex cbdlock;
> +};
> +
> +/* Driver state enquiry */
> +static bool
> +cbd_configured(struct cbd_private *cbp)
> +{
> +	return (cbp->cbdev != NULL);
> +}
> +
> +/* Implies attached */
> +static bool
> +cbd_backed(struct cbd_private *cbp)
> +{
> +	// XXX: check sc->sc_size == backing disk size
> +	return (cbd_configured(cbp) && cbp->backingdev != NULL);
> +}
> +
> +static int
> +cbd_attach_backend(struct cbd_private *lockedcbp, void *userdata)
> +{
> +	char *pathname;
> +	struct block_device *backingdev;
> +
> +	/* XXX: proper dev validation */
> +	if (lockedcbp->cbdev == NULL) {
> +		return -ENODEV;
> +	}
> +
> +	pathname = kzalloc(PATH_MAX, GFP_KERNEL);
> +
> +	if (pathname == NULL) {
> +		return -ENOMEM;
> +	}
> +	
> +	if (strncpy_from_user(pathname, (void __user *)userdata,
> +			      PATH_MAX) == -EFAULT) {
> +		kfree(pathname);
> +		return -EFAULT;
> +	}
> +
> +	backingdev = blkdev_get_by_path(strim(pathname),
> +					BLK_OPEN_READ|BLK_OPEN_WRITE|BLK_OPEN_EXCL,
> +					exclusive, NULL);
> +
> +	kfree(pathname);
> +	
> +	if (IS_ERR(backingdev)) {
> +		return PTR_ERR(backingdev);
> +	}
> +
> +	set_capacity(lockedcbp->cbdev->bd_disk, bdev_nr_sectors(backingdev));
> +	lockedcbp->backingdev = backingdev;
> +
> +
> +	return 0;
> +}
> +
> +static int
> +cbd_detach_backend(struct cbd_private *lockedcbp)
> +{
> +	/* XXX: proper dev state validity */
> +	if (lockedcbp->cbdev == NULL ||
> +	    lockedcbp->backingdev == NULL) {
> +		return -ENODEV;
> +	}
> +
> +	blkdev_put(lockedcbp->backingdev, exclusive);
> +
> +	lockedcbp->backingdev = NULL;
> +	set_capacity(lockedcbp->cbdev->bd_disk, 0);
> +
> +	return 0;
> +}
> +
> +static int cbd_ioctl(struct block_device *bdev, blk_mode_t mode,
> +			unsigned cmd, unsigned long arg)
> +{
> +	int err = 0;
> +	void __user *userdata = (void __user *)arg;
> +	struct cbd_private *cbp;
> +	cbp = bdev->bd_disk->private_data;
> +
> +	if (cbp == NULL) {
> +		err = -ENXIO;
> +		goto ioctl_out;
> +	}
> +
> +	mutex_lock(&cbp->cbdlock);
> +
> +	if (!cbd_configured(cbp)) {
> +		err = -ENXIO;
> +		goto ioctl_out;
> +	}
> +		
> +	switch(cmd) {
> +	case CBD_ATTACH_BACKEND:
> +		if (cbd_backed(cbp)) {
> +			err = -EBUSY;
> +			break;
> +		}
> +		if (!(mode & BLK_OPEN_WRITE)) {
> +			err = -EPERM;
> +			break;
> +		}
> +		err = cbd_attach_backend(cbp, userdata);
> +		break;
> +	case CBD_DETACH_BACKEND: /* XXX: */
> +		if (!cbd_backed(cbp)) {
> +			err = -ENODEV;
> +			break;
> +		}
> +		if (!(mode & BLK_OPEN_WRITE)) {
> +			err = -EPERM;
> +			break;
> +		}
> +		err = cbd_detach_backend(cbp);
> +		break;
> +	default: /*Pass through */
> +		if (cbd_backed(cbp)) {
> +			err = cbp->backingdev->bd_disk->fops->
> +				ioctl(cbp->backingdev,	mode, cmd, arg);
> +		} else {
> +				err = -ENOTTY;
> +		}
> +		break;
> +	}
> +ioctl_out:
> +	mutex_unlock(&cbp->cbdlock);
> +	return err;
> +}
> +
> +static void cbd_submit_bio(struct bio *bio)
> +{
> +	struct block_device *bdev = bio->bi_bdev;
> +	struct cbd_private *cbp = bdev->bd_disk->private_data;
> +
> +	size_t bio_offset = bio->bi_iter.bi_sector << SECTOR_SHIFT;
> +	/* Model assumes this is cached in driver instance after
> +	 * backing device is attached.
> +	 */
> +	size_t bdevsz = bdev_nr_bytes(bdev);
> +
> +	/* sanity check bio limits */
> +	if ((bio_offset + bio->bi_iter.bi_size) > bdevsz) {
> +		if (bio_op(bio) & REQ_OP_READ) {
> +			/* Clip bio */
> +			bio_offset = ((bio_offset > bdevsz) ? bdevsz : bio_offset);
> +			/* Update the bio */			
> +			bio->bi_iter.bi_size = bdevsz - bio_offset;
> +
> +			bio->bi_iter.bi_sector = (bio_offset >> SECTOR_SHIFT);
> +		}
> +	} else 	{
> +		bio->bi_status = BLK_STS_NOTSUPP;
> +		return;
> +	}
> +
> +	if (cbd_backed(cbp)) {
> +		mutex_lock(&cbp->cbdlock);
> +		/* Pass through to backing dev */
> +		bio_set_dev(bio, cbp->backingdev);
> +		mutex_unlock(&cbp->cbdlock);
> +		submit_bio_noacct(bio);
> +	} else {
> +		bio->bi_status = BLK_STS_OFFLINE;
> +	}
> +
> +	return;
> +
> +}
> +
> +static const struct block_device_operations cbd_fops = {
> +	.owner =		THIS_MODULE,
> +	.ioctl =		cbd_ioctl,
> +	.submit_bio =		cbd_submit_bio,
> +};
> +
> +
> +static int __init cbd_init(void)
> +{
> +	int err = 0;
> +	struct block_device *bdev;
> +	struct gendisk *gendisk;
> +	struct cbd_private *cbp;
> +
> +	cbp = kzalloc(sizeof(struct cbd_private),
> +		      GFP_KERNEL);
> +
> +	if (cbp == NULL) {
> +		return -ENOMEM;
> +	}
> +
> +	gendisk = blk_alloc_disk(NUMA_NO_NODE);
> +
> +	if (gendisk == NULL) {
> +		kfree(cbp);		
> +		goto out;
> +	}
> +
> +	sprintf(gendisk->disk_name, "cbd");
> +	gendisk->fops = &cbd_fops;
> +
> +	/* Since we pass through for now. XXX: review */
> +	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, gendisk->queue);
> +	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, gendisk->queue);
> +
> +	gendisk->private_data = cbp;
> +
> +	/* Note: set_capacity() is called later when the backend is attached.
> +	 *	 XXX: Will this work ?
> +	 */
> +	err = add_disk(gendisk);
> +	if (err) {
> +		put_disk(gendisk);
> +		kfree(cbp);
> +		goto out;
> +	}
> +
> +	cbd_major = register_blkdev(0, "cachedrive");
> +	if (cbd_major < 0) {
> +		err = cbd_major;
> +		put_disk(gendisk);
> +		kfree(cbp);
> +		goto out;
> +	} else {
> +		bdev = blkdev_get_by_dev(MKDEV(cbd_major, 0),
> +					 BLK_OPEN_READ|BLK_OPEN_WRITE, exclusive, NULL);
> +		if (IS_ERR(bdev)) {
> +			err = PTR_ERR(bdev);
> +			put_disk(gendisk);
> +			kfree(cbp);
> +			goto out;
> +		}
> +		
> +		if (bdev == NULL) {
> +			put_disk(gendisk);
> +			kfree(cbp);
> +			goto out;
> +		}
> +			
> +		bdev->bd_disk = gendisk;
> +		mutex_init(&cbp->cbdlock);
> +		mutex_lock(&cbp->cbdlock);
> +		cbp->cbdev = bdev;
> +		mutex_unlock(&cbp->cbdlock);
> +		err = 0; /* Mark success */
> +	}
> +
> +out:
> +	return err;
> +}
> +
> +static void __exit cbd_exit(void)
> +{
> +	struct block_device *bdev;
> +	struct gendisk *gendisk;
> +	struct cbd_private *cbp;
> +	
> +	bdev = blkdev_get_by_dev(MKDEV(cbd_major, 0),
> +					 BLK_OPEN_READ|BLK_OPEN_WRITE, exclusive, NULL);
> +
> +	if (bdev == NULL) {
> +		// XXX: panic() or something else ?
> +		panic("can't find allocated block device major number %d\n", cbd_major);
> +	}
> +
> +	gendisk = bdev->bd_disk;
> +	cbp = gendisk->private_data;
> +
> +	mutex_lock(&cbp->cbdlock);
> +	if (cbp->backingdev != NULL) {
> +		mutex_unlock(&cbp->cbdlock);
> +		cbd_detach_backend(cbp);
> +	}
> +	mutex_unlock(&cbp->cbdlock);
> +
> +	put_disk(gendisk);
> +	kfree(cbp);
> +	blkdev_put(bdev, exclusive);
> +
> +	unregister_blkdev(cbd_major, "cbd");
> +}
> +
> +module_init(cbd_init);
> +module_exit(cbd_exit);
> +
> +MODULE_LICENSE("GPL");
> +
> diff -urN cbd.null/linux/Makefile cbd/linux/Makefile
> --- cbd.null/linux/Makefile	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/linux/Makefile	2023-10-16 09:20:14.033674649 +0000
> @@ -0,0 +1,10 @@
> +obj-m += cbd.o
> +LINUXSRC ?= $(HOME)/linux #For dev, for now.
> +# The "standard seems to be"
> +#LINUXSRC?=/lib/modules/$(shell uname -r)/build
> +
> +all:
> +	make -C $(LINUXSRC)  M=$(PWD) modules
> +
> +clean:
> +	make -C $(LINUXSRC) M=$(PWD) clean
> diff -urN cbd.null/Makefile cbd/Makefile
> --- cbd.null/Makefile	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/Makefile	2023-10-21 17:25:46.201831270 +0000
> @@ -0,0 +1,96 @@
> +# This set of spinroot related files were written by MattC
> +#<c@bow.st>  in the Gregorian Calendar year AD.2023, in the month
> +# of February that year.
> +#
> +# We have two specification files and a properties file (".inv")
> +#
> +# The properties file contains a "constraint" sections
> +# such as ltl or never claims (either or, not both).
> +#
> +# The specification is divided into two files:
> +# the file with suffix '.drv' is a "driver" which
> +# instantiates processes that will ultimately "drive" the
> +# models under test.
> +# The file with the suffix '.pml' contains the process
> +# model code, which, is intended to be the formal specification
> +# for the code we are interested in writing in C.
> +#
> +# A file with a '.pmh' extension is a "header" file which
> +# both the driver and the model can use.
> +#
> +# We process these files in slightly different ways during
> +# the dev cycle, but broadly speaking, the idea is to generate
> +# a file called 'spinmodel.pml' which contains the final
> +# model file that is fed to spin.
> +#
> +# During a model extraction verification run, "modex" is run to
> +# extract the 'specification' from C code written to implement
> +# the model defined above. We use a 'harness' file (see file with
> +# suffix '.prx' below.
> +#
> +# Once the harness has been run, spinmodel.pml should be
> +# synthesised and processed as usual.
> +#
> +# The broad idea is that software development starts by writing the
> +# spec first, validating the model, and then implementing the model in
> +# C, after which we come back to extract the model from the C file
> +# and cross check our implementation using spin.
> +#
> +# If things go well, the constraints specified in the '.inv' file
> +# should hold exactly for both the handwritten model, and the
> +# extracted one.
> +
> +spin-gen: cbd.pml cbd.drv cbd.inv
> +	cp cbd.pml model #mimic modex - see below.
> +	cat model >> spinmodel.pml;cat cbd.drv >> spinmodel.pml;cat cbd.inv >> spinmodel.pml;
> +	spin -am spinmodel.pml
> +	cc -DVECTORSZ=65536 -o cbd.pan pan.c
> +
> +all: spin-gen prog
> +
> +# Verification related targets.
> +spin-run: spinmodel.pml
> +	./cbd.pan -a #Generate cbd.pml.trail	on error
> +	@test -f spinmodel.pml.trail && spin -t spinmodel.pml -p -g -l && ./cbd.pan -r spinmodel.pml.trail -g || true
> +
> +# Modex Extracts from C code to 'model' - see cbd.linux.prx
> +modex-linux: cbd.linux.prx cbd.drv cbd.inv linux/cbd.c
> +	modex -v -w cbd.linux.prx
> +	echo "//Included via command line - see Makefile:modex-*:\n\n\n#include \"cbd.pmh\"\n\n"  >> spinmodel.pml #include "cbd.pmh" - avoid modex cpp expansion
> +	cat model >> spinmodel.pml;cat cbd.drv >> spinmodel.pml;cat cbd.inv >> spinmodel.pml;
> +	spin -am spinmodel.pml #Sanity check
> +	cc -DVECTORSZ=65536 -o cbd.pan pan.c
> +
> +# Modex Extracts from C code to 'model' - see cbd.NetBSD.prx
> +modex-NetBSD: cbd.NetBSD.prx cbd.drv cbd.inv NetBSD/cbd.c
> +	modex -v -w cbd.NetBSD.prx
> +	echo "//Included via command line - see Makefile:modex-*:\n\n\n#include \"cbd.pmh\"\n\n"  >> spinmodel.pml #include "cbd.pmh" - avoid modex cpp expansion
> +	cat model >> spinmodel.pml;cat cbd.drv >> spinmodel.pml;cat cbd.inv >> spinmodel.pml;
> +	spin -am spinmodel.pml #Sanity check
> +	cc -DVECTORSZ=65536 -o cbd.pan pan.c
> +
> +# Housekeeping
> +modex-gen-clean:
> +	rm -f spinmodel.pml # Our consolidated model file
> +	rm -f _spin_nvr.tmp # Never claim file
> +	rm -f model # modex generated intermediate "model" file
> +	rm -f pan.* # Spin generated source files
> +	rm -f _modex* # modex generated script files
> +	rm -f linux/cbd.[IM]
> +	rm -f NetBSD/cbd.[IM]
> +
> +prog-clean:
> +	rm -f cbd
> +
> +spin-run-clean:
> +	rm -f spinmodel.pml.trail
> +
> +spin-gen-clean:
> +	rm -f cbd.pan # model executables.
> +	rm -f spinmodel.pml # Consolidated model source files
> +	rm -f _spin_nvr.tmp # Never claim file
> +	rm -f model # Intermediate "model" file
> +	rm -f pan.* # Spin generated source files
> +
> +clean: modex-gen-clean spin-gen-clean spin-run-clean prog-clean
> +	rm -f *~
> diff -urN cbd.null/NetBSD/cbd.c cbd/NetBSD/cbd.c
> --- cbd.null/NetBSD/cbd.c	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/NetBSD/cbd.c	2023-10-23 06:37:45.843939111 +0000
> @@ -0,0 +1,588 @@
> +#include <sys/types.h>
> +#include <sys/stat.h>
> +#include <sys/buf.h>
> +#include <sys/bufq.h>
> +#include <sys/conf.h>
> +#include <sys/disk.h>
> +#include <sys/disklabel.h>
> +#include <sys/errno.h>
> +
> +#include <uvm/uvm_prot.h>
> +#include <sys/acl.h>
> +#include <sys/vnode_if.h>
> +#include <sys/vnode.h>
> +
> +#include <sys/module.h>
> +
> +#include <sys/fcntl.h>
> +
> +#define CBD_ATTACH_BACKEND 222 /* XXX: fit into ioctl namespace */
> +#define CBD_DETACH_BACKEND 333 /* XXX: ditto */
> +
> +static void cbd_attach(device_t, device_t, void *);
> +static int cbd_detach(device_t, int);
> +
> +static dev_type_open(cbd_open);
> +static dev_type_close(cbd_close);
> +static dev_type_read(cbd_read);
> +static dev_type_write(cbd_write);
> +static dev_type_ioctl(cbd_ioctl);
> +static dev_type_strategy(cbd_strategy);
> +static dev_type_size(cbd_size);
> +
> +struct cbd_ioctl {
> +	const char	*diskpath; /* Path to backing block disk dev node */
> +	struct lwp	*l;	   /* Userland caller lwp */
> +};
> +
> +const struct dkdriver cbddkdriver = {
> +        .d_open = cbd_open,
> +        .d_close = cbd_close,
> +        .d_strategy = cbd_strategy,
> +        .d_minphys = minphys,
> +};
> +
> +struct cbd_softc {
> +	device_t sc_dev;		/* Back ref to autoconf dev ptr. */
> +	struct  disk    sc_dk;          /* generic disk information */
> +	kmutex_t sc_lock;		/* Protects access to instance of this struct. */
> +	struct bufq_state *sc_buflist;	/* transaction request/reply queue */
> +	struct vnode		*sc_tvn;	/* backing device
> +						 * vnode */
> +	int	sc_tvn_bsize;		/* Backing device size, which
> +					 * is also the size of our
> +					 * device
> +					 */
> +	struct kauth_cred *sc_tvn_l_cred;	/* Creds used with sc_tvn */
> +};
> +
> +const struct bdevsw cbd_bdevsw = {
> +	.d_open = cbd_open,
> +	.d_close = cbd_close,
> +	.d_strategy = cbd_strategy,
> +	.d_ioctl = cbd_ioctl,
> +	.d_dump = nodump,
> +	.d_psize = cbd_size,
> +	.d_discard = nodiscard,
> +	.d_flag = D_DISK | D_MPSAFE
> +};
> +
> +const struct cdevsw cbd_cdevsw = {
> +	.d_open = cbd_open,
> +	.d_close = cbd_close,
> +	.d_read = cbd_read,
> +	.d_write = cbd_write,
> +	.d_ioctl = cbd_ioctl,
> +	.d_stop = nostop,
> +	.d_tty = notty,
> +	.d_poll = nopoll,
> +	.d_mmap = nommap,
> +	.d_kqfilter = nokqfilter,
> +	.d_discard = nodiscard,
> +	.d_flag = D_DISK | D_MPSAFE
> +};
> +
> +CFATTACH_DECL3_NEW(cbd, sizeof(struct cbd_softc),
> +	0, cbd_attach, cbd_detach, NULL, NULL, NULL, DVF_DETACH_SHUTDOWN);
> +
> +#ifdef _MODULE
> +MODULE(MODULE_CLASS_DRIVER, cbd, NULL);
> +CFDRIVER_DECL(cbd, DV_DISK, NULL);
> +
> +
> +
> +static int
> +cbd_modcmd(modcmd_t cmd, void *arg)
> +{
> +	devmajor_t bmajor = -1, cmajor = -1;
> +
> +	int error = 0;
> +	switch (cmd) {
> +	case MODULE_CMD_INIT:
> +
> +		error = devsw_attach("cbd", &cbd_bdevsw, &bmajor,
> +		    &cbd_cdevsw, &cmajor);
> +
> +		if (error) {
> +			break;
> +		}
> +
> +		error = config_cfdriver_attach(&cbd_cd);
> +
> +		if (error) {
> +			devsw_detach(&cbd_bdevsw, &cbd_cdevsw);
> +			break;
> +		}
> +		
> +		error = config_cfattach_attach(cbd_cd.cd_name, &cbd_ca);
> +	        if (error) {
> +			config_cfdriver_detach(&cbd_cd);
> +			devsw_detach(&cbd_bdevsw, &cbd_cdevsw);
> +			break;
> +		}
> +
> +		break;
> +
> +	case MODULE_CMD_FINI:
> +		error = config_cfattach_detach(cbd_cd.cd_name, &cbd_ca);
> +		if (error) {
> +			break;
> +		}
> +		error = config_cfdriver_detach(&cbd_cd);
> +		if (error) {
> +			break;
> +		}
> +
> +		devsw_detach(&cbd_bdevsw, &cbd_cdevsw);
> +		break;
> +	case MODULE_CMD_STAT:
> +		error = ENOTTY;
> +		break;
> +
> +	default:
> +		error = ENOTTY;
> +		break;
> +	}
> +
> +	return error;
> +		
> +}
> +
> +
> +#endif
> +
> +static void cbd_attach(device_t, device_t, void *);
> +static int cbd_detach(device_t, int);
> +static bool
> +is_read(struct buf *buf)
> +{
> +	return ((buf->b_flags & B_READ) == B_READ);
> +}
> +
> +#if notyet
> +static bool
> +is_write(struct buf *buf)
> +{
> +	return ((buf->b_flags & B_WRITE) == B_WRITE);
> +}
> +#endif
> +
> +/*
> + * The idea here is that the state sequentially progresses
> + * forwards as configuration completes.
> + *
> + * So for eg: a device that has a caching device setup,  implies it is
> + * already cbd_backed(), but not vice-versa, because an unfronted
> + * backed device is merely an uncached "passthrough" situation.
> + */
> +
> +static bool
> +cbd_configured(struct cbd_softc *sc)
> +{
> +	/*
> +	 * Note: device_t is a pointer, no specific "NULL" typedef
> +	 * available
> +	 */
> +	return (sc->sc_dev != NULL);
> +}
> +
> +/* Implies attached */
> +static bool
> +cbd_backed(struct cbd_softc *sc)
> +{
> +	// XXX: check sc->sc_size == backing disk size
> +	return (cbd_configured(sc) && sc->sc_tvn != NULL);
> +}
> +
> +static void
> +cbd_attach(device_t parent, device_t self, void *aux)
> +{
> +	struct cbd_softc *sc = device_private(self);
> +
> +	mutex_init(&sc->sc_lock, MUTEX_DEFAULT, IPL_NONE);
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (cbd_configured(sc)) { /* Sorry, busy */
> +		mutex_exit(&sc->sc_lock);
> +	}
> +
> +	sc->sc_dev = self;
> +
> +        /* Initialize and attach the disk structure. */
> +        disk_init(&sc->sc_dk, device_xname(self), &cbddkdriver);
> +        disk_attach(&sc->sc_dk);
> +
> +	bufq_alloc(&sc->sc_buflist, "fcfs", 0);
> +
> +	mutex_exit(&sc->sc_lock);
> +
> +	if (!pmf_device_register(self, NULL, NULL))
> +		aprint_error_dev(self, "couldn't establish power handler\n");
> +}
> +
> +static int
> +cbd_detach(device_t self, int flags)
> +{
> +	struct cbd_softc *sc = device_private(self);
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (!cbd_configured(sc)) {
> +		mutex_exit(&sc->sc_lock);
> +		return ENXIO;
> +	}
> +
> +	/* We assume the !(flags & DETACH_FORCE) case here. */
> +	if (((flags & DETACH_FORCE) == 0) &&
> +	    (bufq_peek(sc->sc_buflist) != NULL)) {
> +		mutex_exit(&sc->sc_lock);
> +		return EBUSY; /* There are pending transactions */
> +	} else { /* DETACH_FORCE */
> +		bufq_drain(sc->sc_buflist);
> +		//XXX: Tell backing device to drain/flush etc ?
> +	}
> +
> +	// XXX: detach backed/fronted devices ?
> +	// quiesce everything first, then sc->sc_tvn = NULL; ?
> +	// All threads need to cease related  activity.
> +
> +	mutex_exit(&sc->sc_lock);
> +
> +	pmf_device_deregister(self);
> +	bufq_free(sc->sc_buflist);
> +        disk_detach(&sc->sc_dk);
> +
> +	mutex_destroy(&sc->sc_lock);
> +
> +	return 0;
> +}
> +
> +static int
> +cbd_open(dev_t dev, int flag, int ifmt, struct lwp *l)
> +{
> +	/* Sanity check params */
> +	switch(ifmt) {
> +		case S_IFCHR:
> +		case S_IFBLK:
> +			break;
> +	default:
> +		return EINVAL;
> +	}
> +
> +	int unit;
> +	struct cbd_softc *sc;
> +	
> +	unit = DISKUNIT(dev);
> +	sc = device_lookup_private(&cbd_cd, unit);
> +
> +	/*
> +	 * Trying to open unconfigured dev.
> +	 * cbdconfig(8) should be run first.
> +	 */
> +	if (sc == NULL) {
> +		return ENXIO;
> +	}
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (!cbd_backed(sc)) {
> +		mutex_exit(&sc->sc_lock);
> +		return ENXIO;
> +	}
> +
> +	mutex_exit(&sc->sc_lock);
> +
> +	return 0;
> +}
> +
> +
> +static int
> +cbd_close(dev_t dev, int flag, int ifmt, struct lwp *l)
> +{
> +	/* Sanity check params */
> +	switch(ifmt) {
> +		case S_IFCHR:
> +		case S_IFBLK:
> +			break;
> +	default:
> +		return EINVAL;
> +	}
> +
> +	int unit;
> +	struct cbd_softc *sc;
> +	
> +	unit = DISKUNIT(dev);
> +	sc = device_lookup_private(&cbd_cd, unit);
> +
> +	/*
> +	 * Trying to close unconfigured dev.
> +	 * cbdconfig(8) should be run first.
> +	 */
> +	if (sc == NULL) {
> +		return ENXIO;
> +	}
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (!cbd_backed(sc)) {
> +		mutex_exit(&sc->sc_lock);
> +		return ENXIO;
> +	}
> +
> +	mutex_exit(&sc->sc_lock);
> +	return 0;
> +}
> +
> +
> +static void
> +cbd_strategy(struct buf *buf)
> +{
> +
> +	dev_t dev = buf->b_dev;
> +
> +	int unit;
> +	struct cbd_softc *sc;
> +
> +	unit = DISKUNIT(dev);
> +	sc = device_lookup_private(&cbd_cd, unit);
> +
> +	if (sc == NULL) {
> +		return;
> +	}
> +
> +	/* Sanity check buffer */
> +	if ((dbtob(buf->b_blkno) + buf->b_bcount) > sc->sc_tvn_bsize) {
> +		if (BUF_ISREAD(buf)) {
> +			/* Clip offset */
> +			buf->b_blkno = (dbtob(buf->b_blkno) > sc->sc_tvn_bsize) ? btodb(sc->sc_tvn_bsize) : buf->b_blkno;
> +			/* Update the request length */
> +			buf->b_bcount = (sc->sc_tvn_bsize - dbtob(buf->b_blkno));
> +		} else {
> +			buf->b_error = EINVAL;
> +			biodone(buf);
> +			return;
> +		}
> +	}
> +
> +
> +	if (cbd_backed(sc)) {
> +		mutex_enter(&sc->sc_lock);
> +		disk_busy(&sc->sc_dk);
> +		VOP_STRATEGY(sc->sc_tvn, buf);
> +		disk_unbusy(&sc->sc_dk, buf->b_bcount, is_read(buf));
> +		mutex_exit(&sc->sc_lock);
> +	} else {
> +		buf->b_error = ENXIO;
> +		biodone(buf);
> +		return;
> +	}
> +	
> +	/* We assume that the backing driver has frobbed buf
> +	 * appropriately, for return;
> +	 */
> +}
> +
> +static int
> +cbd_attach_backend(struct cbd_softc *lockedsc, void *data)
> +{
> +	struct cbd_ioctl *cbdioctl = data;
> +
> +	int error = 0;
> +	struct pathbuf *pbuf;
> +	struct	 vnode *vp;
> +
> +	uint64_t numsec;
> +	unsigned int secsz;
> +
> +	/* XXX: proper dev validation */
> +	if (lockedsc->sc_dev == NULL) {
> +		return -ENODEV;
> +	}
> +
> +	error = pathbuf_copyin(cbdioctl->diskpath, &pbuf);
> +	if (error != 0) {
> +		return error;
> +	}
> +
> +	error = vn_bdev_openpath(pbuf, &vp, cbdioctl->l);
> +	pathbuf_destroy(pbuf);
> +	if (error != 0) {
> +		return error;
> +	}
> +
> +	error = getdisksize(vp, &numsec, &secsz);
> +	if (error != 0) {
> +		vn_close(vp, /* See vn_bdev_openpath() */ FREAD | FWRITE, cbdioctl->l->l_cred);
> +		return error;
> +	}
> +
> +	lockedsc->sc_tvn = vp;
> +	lockedsc->sc_tvn_l_cred = cbdioctl->l->l_cred;
> +	lockedsc->sc_tvn_bsize = numsec * secsz;
> +	
> +	return error;
> +}
> +
> +static int
> +cbd_detach_backend(struct cbd_softc *lockedsc)
> +{
> +	/* XXX: proper dev state validity */
> +	if (lockedsc->sc_dev == NULL ||
> +	    lockedsc->sc_tvn == NULL ||
> +	    lockedsc->sc_tvn_bsize == 0 ||
> +	    lockedsc->sc_tvn_l_cred == NULL) {
> +		return -ENODEV;
> +	}
> +
> +	vn_close(lockedsc->sc_tvn, /* See vn_bdev_openpath() */ FREAD | FWRITE,
> +		 lockedsc->sc_tvn_l_cred);
> +
> +	lockedsc->sc_tvn_bsize = 0;
> +	lockedsc->sc_tvn_l_cred = NULL;	
> +	lockedsc->sc_tvn = NULL; /* reset */
> +
> +	return 0;
> +}
> +
> +static int
> +cbd_ioctl(dev_t dev, u_long cmd, void *data, int flag, struct lwp *l)
> +{
> +	int unit, error = 0;
> +	struct cbd_softc *sc;
> +	struct cbd_ioctl cbdioctlargs;
> +
> +	unit = DISKUNIT(dev);
> +	sc = device_lookup_private(&cbd_cd, unit);
> +
> +	if (sc == NULL) {
> +		return ENXIO;
> +	}
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (!cbd_configured(sc)) {
> +		mutex_exit(&sc->sc_lock);
> +		return ENXIO;
> +	}
> +	
> +	switch(cmd) {
> +	case CBD_ATTACH_BACKEND:
> +		if (cbd_backed(sc)) {
> +			error = EBUSY;
> +			break;
> +		}
> +		if (!(flag & FWRITE)) {
> +			error = EPERM;
> +		}
> +		cbdioctlargs.diskpath = data;
> +		cbdioctlargs.l = l;
> +		error = cbd_attach_backend(sc, &cbdioctlargs);
> +		break;
> +	case CBD_DETACH_BACKEND:
> +		if (!cbd_backed(sc)) {
> +			error = ENODEV;
> +			break;
> +		}
> +		if (!(flag & FWRITE)) {
> +			error = EPERM;
> +			break;
> +		}
> +		error = cbd_detach_backend(sc);
> +		break;
> +
> +		/* default: Pass through */
> +	}
> +		
> +	error = VOP_IOCTL(sc->sc_tvn, cmd, data, flag, l->l_cred);
> +
> +	mutex_exit(&sc->sc_lock);
> +
> +	return error;
> +}
> +
> +static int
> +cbd_read(dev_t dev, struct uio *uio, int flags)
> +{
> +	int unit;
> +	struct cbd_softc *sc;
> +	
> +	unit = DISKUNIT(dev);
> +	sc = device_lookup_private(&cbd_cd, unit);
> +
> +	if (sc == NULL) {
> +		return ENXIO;
> +	}
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (!cbd_backed(sc)) {
> +		mutex_exit(&sc->sc_lock);
> +		return ENXIO;
> +	}
> +
> +	mutex_exit(&sc->sc_lock);
> +
> +	return physio(cbd_strategy, NULL, dev, B_READ, minphys, uio);
> +}
> +
> +static int
> +cbd_write(dev_t dev, struct uio *uio, int flags)
> +{
> +	int unit;
> +	struct cbd_softc *sc;
> +	
> +	unit = DISKUNIT(dev);
> +	sc = device_lookup_private(&cbd_cd, unit);
> +
> +	/*
> +	 * Trying to close unconfigured dev.
> +	 * cbdconfig(8) should be run first.
> +	 */
> +	if (sc == NULL) {
> +		return ENXIO;
> +	}
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (!cbd_backed(sc)) {
> +		mutex_exit(&sc->sc_lock);
> +		return ENXIO;
> +	}
> +	
> +	mutex_exit(&sc->sc_lock);
> +	
> +	return physio(cbd_strategy, NULL, dev, B_WRITE, minphys, uio);
> +}
> +
> +
> +static int
> +cbd_size(dev_t dev)
> +{
> +	int unit;
> +	struct cbd_softc *sc;
> +	
> +	unit = DISKUNIT(dev);
> +	sc = device_lookup_private(&cbd_cd, unit);
> +
> +	/*
> +	 * Trying to close unconfigured dev.
> +	 * cbdconfig(8) should be run first.
> +	 */
> +	if (sc == NULL) {
> +		return ENXIO;
> +	}
> +
> +	mutex_enter(&sc->sc_lock);
> +
> +	if (!cbd_backed(sc)) {
> +		mutex_exit(&sc->sc_lock);
> +		return ENXIO;
> +	}
> +
> +	// XXPass through.
> +
> +	mutex_exit(&sc->sc_lock);
> +
> +	return -1; // XXX:
> +}
> diff -urN cbd.null/NetBSD/cbd.ioconf cbd/NetBSD/cbd.ioconf
> --- cbd.null/NetBSD/cbd.ioconf	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/NetBSD/cbd.ioconf	2023-10-20 15:40:16.888208026 +0000
> @@ -0,0 +1,8 @@
> +# $NetBSD$
> +
> +ioconf cbd
> +
> +include "conf/files"
> +
> +pseudo-device cbd
> +
> diff -urN cbd.null/NetBSD/Makefile cbd/NetBSD/Makefile
> --- cbd.null/NetBSD/Makefile	1970-01-01 00:00:00.000000000 +0000
> +++ cbd/NetBSD/Makefile	2023-10-20 15:41:52.334710787 +0000
> @@ -0,0 +1,10 @@
> +#	$NetBSD$
> +# Please build using crossbuild nbmake-$ARCH
> +
> +.include "${NETBSDSRCDIR}/sys/modules/Makefile.inc"
> +
> +KMOD=	cbd
> +IOCONF=	cbd.ioconf
> +SRCS=	cbd.c
> +
> +.include <bsd.kmodule.mk>


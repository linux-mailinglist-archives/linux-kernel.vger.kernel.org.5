Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8C97E16BE
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 22:06:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjKEVGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 16:06:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjKEVGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 16:06:47 -0500
Received: from frasgout11.his.huawei.com (frasgout11.his.huawei.com [14.137.139.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B39EE0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Nov 2023 13:06:39 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.18.147.229])
        by frasgout11.his.huawei.com (SkyGuard) with ESMTP id 4SNmsS1mwlz9v7HT
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 04:53:16 +0800 (CST)
Received: from [10.81.208.67] (unknown [10.81.208.67])
        by APP1 (Coremail) with SMTP id LxC2BwBnVnbMA0hlYSIcAA--.32777S2;
        Sun, 05 Nov 2023 22:06:28 +0100 (CET)
Message-ID: <b260c8f8-266f-08c5-2e87-875174042a5b@huaweicloud.com>
Date:   Sun, 5 Nov 2023 22:06:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [RFC+Patch] Formal models as source of truth for Software
 Architects.
To:     "Mathew, Cherry G.*" <c@bow.st>, linux-kernel@vger.kernel.org
References: <85v8axxrmo.fsf@bow.st>
 <2defe3ff-90df-2627-dd19-0442a90b20a4@huaweicloud.com>
 <857cmw2ael.fsf@bow.st>
From:   Jonas Oberhauser <jonas.oberhauser@huaweicloud.com>
In-Reply-To: <857cmw2ael.fsf@bow.st>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: LxC2BwBnVnbMA0hlYSIcAA--.32777S2
X-Coremail-Antispam: 1UD129KBjvJXoWfGr1kGr1DZr18uFWruFWxWFg_yoWktF45pF
        W5K3WYkFs5JFWxCrn7A3WxXa4Fy3yrJFW5Gr95Kwn7Z3s8WFyIqr4fKF1Y9F97Zrs5Ww1Y
        vrWjyr1Du3Z8AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxV
        AFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
        x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
        0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
        wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jrv_JF1lIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
        k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
        c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5mrqt2oorev25kdx2v3u6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathew,


Am 11/5/2023 um 8:20 AM schrieb Mathew, Cherry G.*:
> Hi Jonas,
>
> First of all, sorry for my late reply - I note with thanks, that you
> spent some time and attention on your email, so I wanted to spend some
> time composing a thoughtful reply. I'm replying in context below:
>
>
>>>>>> Jonas Oberhauser<jonas.oberhauser@huaweicloud.com>  writes:
> [...]
>
>
>      > A few years ago we also built systems to extract models from C
>      > code (for TLA+ back then), but those systems are now totally
>      > unused (and unmaintained) due to poor scalability of exploratory
>      > state-based model checking.
>
>      > And then there's the issue that many engineers don't know how to
>      > write reasonable temporal assertions, especially not ones that can
>      > give sufficient guarantees to be worth the extra effort and
>      > maintenance.
>
> So my arrival at "D3" and spin was a progression of looking at what's
> available (in the open domain), current consensus around development
> methodology, and progress in hardware capacity.
>
> I've used TLA+ for protocol verification, and while it's great for that,
> I didn't see it translate to and from implementation code.


I meant that we implemented an internal tool to transpile from C to PlusCal.

It sounded like a great idea at the time. But then it quickly fell out 
of use.


>      > If we use a simplified model of what the system should be doing to
>      > specify, then usually we are not looking for equivalence but only
>      > for uni-directional simulation: the spec usually needs to have
>      > more degrees of freedom than the implementation, which is just a
>      > single implementation.
>
> So spin has two approaches - one uses the inline "C" to glue the spec as
> a sort of "test driver" for implementation code if required. The other
> uses a separate source level model extractor, to rebuild the implicit
> model in the implementation C code. I am leaning towards the latter,
> because it seems to help with streamlining the  software development
> process as an iteration - which helps especially in early nascent stages
> of design & development. What I'm beginning to see is that once design
> "settles down", then the iterations become less disruptive. But
> initially, the Architect/Engineer hats need very good interaction.
>
>
>      > What has worked well for us is anything that works
>
>      > - directly on the code
>
>      > - doesn't require learning any kind of math to find bugs with
>
>      > - is scalable enough to find bugs on real code
>
>      > - doesn't require a lot of extra effort from the engineers
>      > (compared to the extra assurance you get)
>
>      > - doesn't need to be adapted whenever the code changes
>
> Have you seen spoq ?
>
> https://www.usenix.org/conference/osdi23/presentation/li-xupeng
>
> They use this approach - one of the reasons I'm not fully convinced by
> this approach is because, I believe that the source of truth being in
> implementation code limits flexibility, for eg: reuse. If you notice my
> original patch, the model is a reference for both the NetBSD and Linux
> drivers - nothing stops it from further OSs (as long as the codeflow
> logic doesn't vary too much - and even then, the model could itself be
> made modular to accommodate different FSMs)


I have seen it, but it's not exactly what I have in mind. I wouldn't say 
that it doesn't require learning any kind of math to find bugs with.
You're still writing Coq proofs, just with more automation. Nevertheless 
it's going in the direction I'm thinking of.

For reuse, I think the main issue is that implementation code is always 
a source of truth - the truth of what's really going to be executed.
If we want to have a second source of truth, it should be a different 
truth, such as "assumptions of the other parts of the system".

Since you already have this source of truth, if you make a different 
implementation in another kernel, you can compare what the original 
driver was doing with what your new implementation is doing.
There's no need to have yet another copy of what the driver might be doing.



>      > I find in software, usually blueprint and skyscraper are in some
>      > sense the same thing.  Or in some sense, the skyscraper is
>      > extracted automatically by a compiler/interpreter and installation
>      > system - we never actually dig anything ourselves, but have the
>      > ability to experiment directly on the blueprint as we build it.
>
>      > That's because languages already try to provide us reasonable
>      > abstraction mechanisms by which we can simplify the code and make
>      > it more "model-like".
>
> Can you give me an example of how this works/a pre-existing tool that
> helps with this simplification ? I'm actually currently looking at
> re-writing modex to do precisely this (but with the translation
> end-point being something close to the original model).


I think any higher level language, including C, goes into this 
direction. Some are just a lot better at building abstractions and 
describing the code more model-like than tiniest-implementation-detail-like.

(and sometimes that's not what you want).


>      > So writing the blueprint twice - once in some modelling language
>      > and once in a language meant for execution - doesn't really
>      > provide a lot of benefit.  But it requires doing changes at two
>      > levels whenever the software design changes. It just violates DRY.
>
> IMHO, this would be true if:
>
> a) The implementation language was expressive enough to cleanly
>     encapsulate the model.
>
> b) If the toolchain around it were able to do model verification (eg: by
> exploring LTL bounds).


We are building internal tools for such b) things. Not quite exhaustive 
formal verification tools, but tools that can express and check more 
complex properties at source level without false positives.

(They may have false negatives, but that's not really a showstopper. 
False positives would be.)


> I've heard good things about rustlang wrt. a), but not b) - would be
> keen to know more.
>
>      > What makes sense in our experience is identifying properties you
>      > would like the system to have and devising a specific checking
>      > mechanism for that.  For example, you might specify the protocol
>      > of how the device communicates with the system and what
>      > assumptions it has (like "don't start a second command while the
>      > first one hasn't finished"), and then check that the driver code
>      > obeys this policy.  Then you can change the software code without
>      > touching the protocol specification, and just re-verify.
>
>      > In the easiest case, the protocol can be a mock device process
>      > that is inserted via a form of dependency injection to talk to the
>      > real driver code during verification, and if the code isn't too
>      > complex you can exhaustively check several test cases.
>
>
> Ok, from what I understand, this is a "system model" - when I talk about
> D3, I'm purely talking about the software model. This model may be part
> of a larger scope "system model".


I'm not using the word "system" in any "full system" kind of way. I just 
mean any component that interacts with some outside world, such as an 
algorithm, a driver, or the whole kernel.

Usually we are looking for two types of bugs:

  1) the code for some subtle reason isn't doing what one would expect 
from reading the code, e.g., UB, some wrong assumption of atomicity, etc.

  2) the code is doing what it seems to be doing, but that's not the 
right thing

The former can usually be specified in a semi-generic way without 
knowing anything about the application, and without modeling too much of 
the external system.
In the easiest cases, things like -fsanitize=undefined may already catch 
most of these issues, especially when used in combination with some 
other tools (e.g. fuzzers).

But for the latter, we need some way to specify at least what the wrong 
things are, even if we can't specify what the right thing is.
So there it makes sense to specify some of the assumptions of the other 
systems that interact with our system.

E.g., I might not be able to specify a video game, but at least I can 
check that its sequence of opengl calls is well-formed (no half-defined 
objects for example).

But for that I need to explain what it means for a sequence of opengl 
calls to be well-formed.


> Event-B
> http://www.event-b.org/index.html
> https://web-archive.southampton.ac.uk/deploy-eprints.ecs.soton.ac.uk/111/1/sld.ch1.intro.pdf
>
> is an interesting (closed) industry take on what you seem to be
> describing - and they seem to have taken a more "D3" like approach -
> I don't have much insight into their experiences though, although I'm
> speaking to one of their practitioners.


Thanks. I haven't had an opportunity to look into event-b more closely 
yet. Maybe at some point in the future.


>      > Only if the code is highly unreadable for specific reasons like
>      > performance or talking to legacy ABIs, it can make sense to have
>      > an "executable comment" that implements the same functional
>      > behavior in a very concise, readable way (with crud
>      > performance/mock APIs replacing the actual behavior), and check
>      > that the real code and the "executable comment" do "the same
>      > thing".
>
> I'm a bit skeptical about the "doxygen" approach (i've seen this in some
> versions of Java iirc, as well) - basically you're bypassing all the
> goodness that the language parser provides by hiding from it - I'm not
> sure how this is useful other than to shimmy in a specific bandaid
> fix. Which is fine, if you're fighting fires, but I think for a more
> structured approach, I'm not seeing what you're seeing, I'm afraid. Open
> to be signposted though.


By executable comment I mean a comment that has a formal semantics that 
can be executed.

Think more pre&post conditions + ghost code. E.g., for a tricky sort 
algorithm like timsort the comment might be something like

var __ghost_array = copy(input_array);

.... // complicated timsort code here

insertion_sort(&__ghost_array); // timsort should give the same output 
as insertion stort, note that both are stable

for (i in 0...array_len) {
     assert (sorted_array[i] == __ghost_array[i]);
}


This is probably not going to help you find the well-known timsort bug, 
but it might be enough to find more trivial mistakes when rolling your 
own timsort.
Anyways this is what I mean by executable comment - a more readable, 
maintainable implementation of the code that tells you what the code 
ought to be doing + some checks to say that they're really doing the 
same thing.

As I understand, doxygen is just a way to link human-readable 
documentation with code, but maybe I'm wrong about this.


>      > The main issues I see when we look at it through the skyscraper
>      > analogy is that usually people in other engineering disciplines
>      > have CAD tools - backed by very powerful computers - to really
>      > systematically and thoroughly check the design.  What we usually
>      > have is stress testing and some test suites built by hand that
>      > miss many cases.
>
> Interestingly, I was surprised at the amount of compute available "off
> the shelf" - the other day I sent a model for help, saying with a bit of
> trepidation that that it might take about 25G of RAM and thrash the
> machine, so please be careful - the volunteer came back to me and said
> he has 128G RAM  available, and 1TB RAM on a pinch! What takes an hour
> to run on my i5 + 16GB laptop, took him 3minutes!
>
> So in some sense, I believe we're nearing the "Deep Neural Nets" moment,
> when GPU computation took inference to the next level.


Yeah, it's pretty impressive. Actually even the power of laptops is 
pretty impressive.
Things like GenMC or Dat3M can do bounded verification of (slightly 
massaged) C algorithms from the linux kernel by more or less exploring 
the full execution space (of a bounded client) within a couple of 
minutes on a laptop.

But for many scenarios, we are still a factor of at least trillions away 
from using something where exhaustive exploration works - not something 
that we'll fix by tying a bunch of supercomputers together...


best wishes,

jonas



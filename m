Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12FC378067C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358274AbjHRHkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358311AbjHRHj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:39:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E18149EA;
        Fri, 18 Aug 2023 00:37:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76FC06477E;
        Fri, 18 Aug 2023 07:37:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B897CC433C7;
        Fri, 18 Aug 2023 07:37:04 +0000 (UTC)
Message-ID: <ba42791b-54d1-7e85-c12c-88332754c10d@xs4all.nl>
Date:   Fri, 18 Aug 2023 09:37:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH]upi:media: Added rest of the Generic Error Codes to the
 existing list
Content-Language: en-US, nl
To:     Jonathan Corbet <corbet@lwn.net>,
        Bhaskar Chowdhury <unixbhaskar@gmail.com>, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     torvalds@linux-foundation.org, randy.dunlap@oracle.com,
        paulmck@kernel.org, markus.heiser@darmarIT.de
References: <20230807045212.32489-2-unixbhaskar@gmail.com>
 <875y5q67tb.fsf@meer.lwn.net>
From:   Hans Verkuil <hverkuil@xs4all.nl>
In-Reply-To: <875y5q67tb.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/08/2023 20:12, Jonathan Corbet wrote:
> Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:
> 
>> Added rest of the Generic Error Codes to the existing list of codes.
>>
>> cc: torvalds@linux-foundation.org
>> cc: randy.dunlap@oracle.com
>> cc: paulmck@kernel.org
>> cc: corbet@lwn.net
>> cc: markus.heiser@darmarIT.de
>>
>> Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
>> ---
>>  There is a "moreutils" package across the Linux distribution, if you
>>  installed it and that package has a binary name "errno",if you run it with
>>  "-l" or "--list" option, it will show all the error codes.In my system, while
>>  running it shows me precisely, 134 of such codes.YMMV
>>
>>  .../userspace-api/media/gen-errors.rst        | 479 ++++++++++++++++++
>>  1 file changed, 479 insertions(+)
> 
> This document is a list of errors that can be returned by media drivers,
> with a focus on what those errors mean in the media context.  What is
> the point of stuffing it full of error numbers that media drivers will
> never return, along with generic, one-line descriptions?  I'll defer to
> the media folks on this, but I don't think this helps their users.

Indeed, this documents just the media-specific errors, there is no point
in listing all errors here.

Regards,

	Hans

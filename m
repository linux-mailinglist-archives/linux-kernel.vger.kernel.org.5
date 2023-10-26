Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2646C7D7BDD
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 06:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232801AbjJZErI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 00:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZErG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 00:47:06 -0400
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [IPv6:2001:41d0:203:375::b1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB4DD186
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 21:46:59 -0700 (PDT)
Message-ID: <b81ae275-d3ac-4565-a09a-4a5ce38fadf1@monoid.al>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monoid.al; s=key1;
        t=1698295616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dWQZkHYXLmutNyQ8PYxc+IjS1GTW1S8m/4JSjcGgWt8=;
        b=mIek29YMPuCv3/CU8N/wj68n3+LJmA6uur7Ky7YrrEY6WZIlSiVVqYpzxvzEpcTDhGDTQb
        EZi21mQhqEPJHULedHV+JQf7LCJWP2YZswdQoCrWbs+1Jn9SYitTGEG1WGhkY7bvZ+MeC7
        kz7uJIskjpEloG8Xm50J9d4FcIo/Cu1lK2+H55nHFzOTc7iJ/nv2dCTwFnrqZuoHFpGU+E
        ACRsYxm8cNlWIeQMfYh6lRewzPzW6m/bzO9JIpXzPPYFHiPN2JcCvfcXkozU3G+B/R0eLC
        eHoLQf0SpeJuLFjhM+UmaR1Ht8KsOJ4GpFQV+YBUtlxmneN1cRzCsdFaQcCYVw==
Date:   Thu, 26 Oct 2023 12:46:14 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Ellie Hermaszewska <kernel@monoid.al>
Subject: Re: Re: [PATCH v2] hwmon: (asus-ec-sensors) add ROG Crosshair X670E
 Gene.
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     eugene.shalygin@gmail.com, Jean Delvare <jdelvare@suse.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-hwmon@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CAB95QAR-UbfVULOCaZMO4H1AgvzbiHEoSYk-DiYPY6Pg-i7Vag@mail.gmail.com>
 <20231019135640.434752-1-kernel@monoid.al>
 <d013e9a3-df0a-4b8f-a1f3-db3cbd32812f@roeck-us.net>
In-Reply-To: <d013e9a3-df0a-4b8f-a1f3-db3cbd32812f@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 03:35, Guenter Roeck wrote:
 > This is not an acceptable commit description.

This is not acceptable feedback.

I am unable to accept it because it is not clear to me what you think
should be changed.

Is it because I misplaced the message to Eugene? Is it because of the
Greek characters? Is is not descriptive enough of the change, or in the
wrong tense, or has incorrect punctuation? Do I need to include my
testing methodology?

If it's only something minor, then please also feel free to correct it
yourself before applying. If you can't or it's not something minor,
then please let me know what ought to change and I can try to correct it.

If you don't let me know, then I will have to guess and possibly waste 
everyone's time further.

Ellie

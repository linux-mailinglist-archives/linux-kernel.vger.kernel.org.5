Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C870760DB7
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229445AbjGYI5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbjGYI4s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:56:48 -0400
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B6F173D;
        Tue, 25 Jul 2023 01:56:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1690275401;
  x=1721811401;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version;
  bh=mbXQf4QZMqamf4di/Lkgjat435aOqhzJnx84Nfjf8CE=;
  b=ga8AAPdJHFdTqSlKZhSPK0U/KUDp+0nxsFg/6I6QyxNZPHTctPQGFExQ
   kh6BYiyoiyUn9smQ25VVKnhb70DVqc2tV+AbngvJRNa4xQvQZurglldWE
   R7CisVJ3wdK08hnN96J7IDmvFRgVATz40trMqEvMntbger9KvtJJdVoap
   D28RfZyRy2+6WVq+v4+OiJcvamUn61fy/D/8Ta/O3HeKUPEm+0B1L5jO7
   nTyCHWvlK1XkzPkIk74L2g57druRIE/iSoFOW6+RnYGY3EEHjbQs2evnp
   RvwOhj75zgQhK8JBfb1S4fbiP+DJhDFdljXNsm1rT2V8Al/oTl+splWBj
   A==;
References: <cover.1689753076.git.waqar.hameed@axis.com>
 <d218a1bc75402b5ebd6e12a563f7315f83fe966c.1689753076.git.waqar.hameed@axis.com>
 <20230723132216.3c2f4924@jic23-huawei>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>, <kernel@axis.com>,
        <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>
Subject: Re: [PATCH v4 3/3] iio: Add driver for Murata IRS-D200
Date:   Tue, 25 Jul 2023 10:53:54 +0200
In-Reply-To: <20230723132216.3c2f4924@jic23-huawei>
Message-ID: <pndlef4qshl.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail02w.axis.com
 (10.20.40.8)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 23, 2023 at 13:22 +0100 Jonathan Cameron <jic23@kernel.org> wrote:

[...]

> I had some more feedback (see inline) but as it was all very minor, I've
> made the changes whilst applying.  Let me know if I messed anything up!
>
> Applied to the togreg branch of iio.git and pushed out as testing for 0-day
> to see if it can find anything we missed.

Looks good to me! Thank you very much Jonathan!

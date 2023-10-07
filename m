Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06A437BC7DC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 14:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343964AbjJGMwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 08:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343929AbjJGMwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 08:52:36 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFC9AB;
        Sat,  7 Oct 2023 05:52:33 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 75EC27C0;
        Sat,  7 Oct 2023 12:52:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 75EC27C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1696683153; bh=PgWW8D6ZHEnTOunHt8IQOGYCHMCY50wDEuOa7EF0Gis=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=Cw1ttCn9rFw0TyTeC7CdnQpEyIZErUF5czDpJb7KKMWbh1YrKuQ4tDxh+lOOBbYWE
         ZTmQTW5o11R7ZH/2vuzugrm5Zf8ETYGIS4rMq4qX4pmgUGdiHBdIlxbdzPVX4Kivct
         dSNnA0kYjfZXX47zVgx0XJqr3bGG4heSy2jrWcPvSAud2BtNu5KgsdZQwyd8y9fV2C
         vpGOtoahCJUKQOIZXjDkwraEZBWFf9w8jLyqt7MMItZToGpHxBWUyEm4/PF0Fjohr6
         VUdp28VynOqWZJL2STT+lHKZBMpWf9+Cp54Sn3+xOdTuvoHcWVDzCoPrtQ1C5iO2Aw
         uObVv+LxUBXug==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        linux-kernel@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/2] Add support for inlined documentation for kunit and
 kselftests
In-Reply-To: <20231007100946.396187d4@sal.lan>
References: <cover.1693550658.git.mchehab@kernel.org>
 <87pm1vd4kb.fsf@meer.lwn.net> <20231007100946.396187d4@sal.lan>
Date:   Sat, 07 Oct 2023 06:52:32 -0600
Message-ID: <877cnyvblb.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mauro Carvalho Chehab <mchehab@kernel.org> writes:

> Should I wait for you to take a look at patch 1/2 before sending
> a new version?

Go ahead and resend whenever...I'm still digging out from the last few
weeks.

Thanks,

jon

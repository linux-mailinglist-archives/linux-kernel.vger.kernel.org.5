Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB31576382B
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:56:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjGZN4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233917AbjGZN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:56:34 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C072D50;
        Wed, 26 Jul 2023 06:54:47 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4084E7DA;
        Wed, 26 Jul 2023 13:54:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4084E7DA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690379646; bh=MW5bOFxzrLhSKBHftPBeupL1yPglXFxuep3jIA1QI4I=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=NGhL5qpSkS07O3d/ED2NZJOCZBXI+zVHlyPdtIS/01Fgrpuxmelr5TMlCDPa4CQkD
         Cf9Gaamlbaxaxco0a3QoyXi3lWRxve4Zizg6nWxDlMW0sOUVjfl/W/d+nSxF3kVR4v
         VcQIi021YsaUaAUg7byOzifmxqf4Ox/My/9mkoAOjC7SqqxscZ5XeWxOQ3fON1uohe
         a9+rN2+ODiyOJk9GRDFB5GCiwob6THh9ZQ7anWb43/db2gNQ53frQCyYLQYjVmSkDI
         45VlN//l6DwNsXsPi6x+JN0KtIyVXqCs6vrysVWEzekWAqAlmyN6t/ymo9VsISn242
         NksJF0Yz4wTHg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Costa Shulyupin <costa.shul@redhat.com>
Cc:     "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION PROCESS" <workflows@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [RFC PATCH] rework top page and organize toc on the sidebar
In-Reply-To: <CADDUTFzKCrrBT=46F-08_EGrwMxVniDOgdkVr-DhGFTzS3DxOg@mail.gmail.com>
References: <20230724193118.2204673-1-costa.shul@redhat.com>
 <87ila9atuk.fsf@meer.lwn.net>
 <CADDUTFzKCrrBT=46F-08_EGrwMxVniDOgdkVr-DhGFTzS3DxOg@mail.gmail.com>
Date:   Wed, 26 Jul 2023 07:54:04 -0600
Message-ID: <87mszi93sz.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Costa Shulyupin <costa.shul@redhat.com> writes:

>> This patch is somewhat difficult to apply, as a result of:
>> > Content-Type: text/plain; charset=3Dtrue
>
> This is caused by em dash in the context line:
> The following manuals are written for *users* of the kernel =E2=80=94 tho=
se who are
>
> I haven't found how to fix it. Are there any tips?

No, it won't be the em-dash.  "true" is not a valid charset.

jon

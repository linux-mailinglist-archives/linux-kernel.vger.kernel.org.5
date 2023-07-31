Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 656B4769BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjGaQJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233169AbjGaQJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:09:19 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A76A7;
        Mon, 31 Jul 2023 09:09:18 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4EA1C2C5;
        Mon, 31 Jul 2023 16:09:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4EA1C2C5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1690819758; bh=eR4erEXoskpp2wPOIwLWNs9bI1tDQ8zmatEAa2TxJko=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=giDX3j07+6YKkFOlgHrvH/C9aZ5BMxdkh7WUT52j8zdqmjqxjVCC5IowbLhmPiamw
         Fj2dGwGGEE0sp1nvv12wEZeFzFc7EKDxE+RO/CA5+OPH6ZgQ3ADe20ifgIqhUA+kE/
         hJ0QlcEwSRxqGBNxLU60pqqTEqtRXmXXLYUniXyGD0ycXxsm/LX1kLUASl1LSLRRvt
         aaDiYzKIMYQ34imaJKHR7YXb0sL7le9rlIqIxf8bfT/aA1CKb8Tiq/6EXdJTOZGaHL
         jSQ/WzqZ27Iy9HXGOXteZMTeRJDrKefwSgD5qIia3B1fMZsTqnFDcnxEi92woPtFFi
         mWlJQ9ngp/F7Q==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Hu Haowen <src.res.211@gmail.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] docs/zh_TW: update zh_TW's documentation from an
 ascensive aspect
In-Reply-To: <87h6pm4ui5.fsf@meer.lwn.net>
References: <20230724041715.20050-1-src.res.211@gmail.com>
 <6ae7f65b-593f-75bc-2f34-c08de719b2fc@gmail.com>
 <87h6pm4ui5.fsf@meer.lwn.net>
Date:   Mon, 31 Jul 2023 10:09:16 -0600
Message-ID: <877cqgdpw3.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Corbet <corbet@lwn.net> writes:

> Hu Haowen <src.res.211@gmail.com> writes:
>
>> Did you receive my patches? Please get down to them soon because I have
>> another series of patches pending on until the current patches are
>> resolved.
>
> Yes, I receive your patches.
>
> I'll ask you again: please be a little more patient.  I will get to
> them.

I still cannot apply your patches:

> WARNING: Message contains suspicious unicode control characters!
>          Subject: [PATCH v2 5/6] docs/zh_TW: update process
>             Line:  =EF=BB=BF.. _tw_process_statement_kernel:
>             -------^
>             Char: ZERO WIDTH NO-BREAK SPACE (0xfeff)
>          If you are sure about this, rerun with the right flag to allow.
> AM FAILED
>=20

I'll ask again: please send me a version lacking weird Unicode control
characters.

Thanks,

jon

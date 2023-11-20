Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE437F1508
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 15:01:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbjKTOBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 09:01:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232148AbjKTOBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 09:01:38 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B508B113;
        Mon, 20 Nov 2023 06:01:33 -0800 (PST)
Received: from localhost (unknown [98.53.138.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 4CA05537;
        Mon, 20 Nov 2023 14:01:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 4CA05537
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1700488892; bh=ZXzp3xho3YcWXFR16yxCrIjW/+bZNdVtNTHyia9WmDQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=siMlOYcP0KUqEDXAbCMHBgj3iC+VtsWd0csrPEHuV6DQCsm46yeBpDmoaDw+ztZUY
         +dZqwLN8qDb/GuFR4QqZgOQ9Eo4e+A8ycqO7826NrPe6bLMSjKOutLTRNC5ZZzC8UP
         d/dAdGxl/acgIgh+Yecn9kNgVs3RQ0BdfD3b1htVTKtqUYhijdVVsfC25fBnBK9J8g
         VFV9o9lxYb6dHyAvra+Tuw3M74i8cS3OKxi7vMhV0An7OCdYJhh//wCpy1qBZE6mwc
         xLa9eQtGrtglXaD8fgIqKFSCUcAXD76S9NUg6/i0omnoDAXhGth3A2z+q7yji/NS5E
         0T1dpQypu4vow==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     jens.wiklander@linaro.org, vegard.nossum@oracle.com,
        Rijo-john.Thomas@amd.com, balint.dobszay@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Subject: Re: [PATCH v2] Documentation: Destage TEE subsystem documentation
In-Reply-To: <CAFA6WYNW_cAFVMTpqPQjwBASKDp_b=CpccCzx23jHn_+qoJrDQ@mail.gmail.com>
References: <20231103061715.196294-1-sumit.garg@linaro.org>
 <CAFA6WYNW_cAFVMTpqPQjwBASKDp_b=CpccCzx23jHn_+qoJrDQ@mail.gmail.com>
Date:   Mon, 20 Nov 2023 07:01:22 -0700
Message-ID: <87y1es5xsd.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sumit Garg <sumit.garg@linaro.org> writes:

> Hi Jonathan,
>
> If you are fine with this destaging TEE documentation patch then will
> you be picking up this patch? Or would you like Jens to pick it up
> with your Ack?

I'm happy to pick it up.

Thanks,

jon

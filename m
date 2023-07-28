Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6971F76656A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234305AbjG1HeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231910AbjG1HeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:34:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1F42B6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:34:21 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1690529659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0q7ZkqD976QaRX4q/NSN/jN/78AbCP8awYpnsIUk6U=;
        b=m7SNnHIZYKmg4VVGejNry+NxciJ/rSqsQUU7oTIs/m7D0Nbpa06X8opBmlls6hRUCnwXPJ
        Y3F/iV4FA47E4FGKUSTrYLZy3f4A4DoRFtXzBouOUUK8M9JHF2xSrxkLboQxXKdo5qCYEM
        fPO+eqTLdwX43ZobimW5++OHf21LY74ie+UIB4j3fdSfPPbUCn+qwqhDe84lrcewi30WgK
        7C6lV6+DzcltdOZEO5ME2a+Cqk6MbM03/mQXAWp5MtDVOLWh43Vmg35sHDTzdittLdYTaA
        oQ1R9cc4EhpsB3tRb4QF/Jz9VoTbtmhW3l0UFihVoKctF/lB0WRT5qwNqE3WQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1690529659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h0q7ZkqD976QaRX4q/NSN/jN/78AbCP8awYpnsIUk6U=;
        b=rLgC1AS96eINluIBgrLl0VepR791Cj5VoBDjGugoOuZP/hq8D+pjFKf3oL2mqsZ1Cl1WuH
        Go3QSiVN6lqo/9Ag==
To:     Zhang Rui <rui.zhang@intel.com>, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, vkuznets@redhat.com
Subject: Re: [PATCH] cpu/SMT: Fix cpu_smt_possible() comment
In-Reply-To: <20230710032121.8341-1-rui.zhang@intel.com>
References: <20230710032121.8341-1-rui.zhang@intel.com>
Date:   Fri, 28 Jul 2023 09:34:18 +0200
Message-ID: <87zg3gqykl.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10 2023 at 11:21, Zhang Rui wrote:
> The comment of cpu_smt_possible() is not aligned with the changelog of
> commit e1572f1d08be ("cpu/SMT: create and export cpu_smt_possible()"),
> and it is wrong.

Why? Do I need to go and read that commit log and figure out what's wrong?

> Fix cpu_smt_possible() comment.

Zero information.


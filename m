Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F8B37ED54F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjKOVDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:03:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344680AbjKOVDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:03:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDA71BE2;
        Wed, 15 Nov 2023 13:02:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E94AC433C8;
        Wed, 15 Nov 2023 21:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700082174;
        bh=amAyqsi96+KIo8jVI7yrm8bYp50p+LjkFfJin590EQY=;
        h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
        b=tQU52lc1JSc3olebP0l3uSjB4xeMi0lcT0q5n8jHrSb7mBhlt7LyhqnzDZRmbLr2A
         f6HlCOCcJgjEWCGnedxgfZ28jWHFDeUSuRXPLhTe7e0ud0Rz3QKwcl7KNh1Ntv+gcX
         RoDL80kx6+r0xdOelwlHsxSOrPROCnyTKUvqNK6nmkMofnRRg7XmWQ5RjHRlCDPo+A
         G6hfugcRuqKvKha5nF4OMeJkJth00I2dP1GodwfE0iD61qEB2oQxQxBPwMAfU3GGts
         pAQrlkuP4RUR5ZhncqfaEkSKZw6ni5sR7r9J2tc8ygAcmTCELV/LrLanXDy6UGb3WG
         tt276Q2ocE5AQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Nov 2023 23:02:48 +0200
Message-Id: <CWZOTY9J9VUU.39FYDBM2MZ153@kernel.org>
To:     "Jerry Snitselaar" <jsnitsel@redhat.com>
Cc:     <linux-integrity@vger.kernel.org>, <keyrings@vger.kernel.org>,
        "James Bottomley" <James.Bottomley@hansenpartnership.com>,
        "William Roberts" <bill.c.roberts@gmail.com>,
        "Stefan Berger" <stefanb@linux.ibm.com>,
        "David Howells" <dhowells@redhat.com>,
        "Jason Gunthorpe" <jgg@ziepe.ca>,
        "Mimi Zohar" <zohar@linux.ibm.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "James Bottomley" <jejb@linux.ibm.com>,
        "Paul Moore" <paul@paul-moore.com>,
        "James Morris" <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        "Julien Gomes" <julien@arista.com>,
        "Mario Limonciello" <mario.limonciello@amd.com>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:SECURITY SUBSYSTEM" 
        <linux-security-module@vger.kernel.org>
Subject: Re: [PATCH v3 2/6] tpm: Store TPM buffer length
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
X-Mailer: aerc 0.15.2
References: <20231024011531.442587-1-jarkko@kernel.org>
 <20231024011531.442587-3-jarkko@kernel.org>
 <lifu6orgfo57usei3szyfrmr6ofl37477gji5xh5bwkhftswxg@cjwwa5okjshi>
In-Reply-To: <lifu6orgfo57usei3szyfrmr6ofl37477gji5xh5bwkhftswxg@cjwwa5okjshi>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 6, 2023 at 9:26 PM EET, Jerry Snitselaar wrote:
>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>

Thanks.

BR, Jarkko
